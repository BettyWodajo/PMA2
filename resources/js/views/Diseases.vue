<template>
  <v-card>
    <v-card-title>
      Diseases
      <v-spacer></v-spacer>
      <v-btn @click="dialog = true" small>New Disease</v-btn>
    </v-card-title>
    <v-card-text>
      <v-data-table :headers="headers" :items="diseases" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.name }}</td>
          <td>{{ props.item.symptom }}</td>
          <td>
            <ul v-for="(description, i) in JSON.parse(props.item.description)" :key="i">
              <li>{{ description.name }}</li>
            </ul>
          </td>
          <td>
            <v-btn small fab @click="edit(props.item)">
              <v-icon>edit</v-icon>
            </v-btn>
          </td>
        </template>
      </v-data-table>
    </v-card-text>

    <!-- add dialog -->
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title class="grey lighten-2" primary-title>{{mode}} disease</v-card-title>
        <v-card-text>
          <v-form v-model="valid" ref="form" lazy-validation>
            <v-flex xs12>
              <v-text-field
                label="Name"
                v-model="disease.name"
                type="text"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="Symptom"
                v-model="disease.symptom"
                type="text"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
              ></v-text-field>
            </v-flex>
            <v-divider></v-divider>
            <v-flex>
              <h3>Descriptions</h3>
            </v-flex>
            <v-flex xs12 v-for="(description, i) in disease.description" :key="i">
              <v-text-field
                v-model="disease.description[i].name"
                type="text"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
                append-icon="remove"
                @click:append="removeDescription(i)"
              ></v-text-field>
            </v-flex>
            <v-btn @click="addDescription()">Add description</v-btn>
          </v-form>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error" flat @click="closeDialog()">Cancel</v-btn>
          <v-btn color="primary" v-if="mode == 'Add'" flat @click="addDisease()">Add</v-btn>
          <v-btn color="primary" v-if="mode == 'Edit'" flat @click="update(disease.id)">Update</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
import Axios from "axios";
export default {
  data() {
    return {
      disease: {
        name: "",
        symptom: "",
        description: [{ name: "" }]
      },
      mode: "Add",
      valid: true,
      dialog: false,
      headers: [
        { text: "Name", value: "name" },
        { text: "Symptom", value: "symptom" },
        { text: "Description", value: "description" },
        { text: "Actions", value: "actions" }
      ],
      diseases: [],
      rules: {
        required: {
          required: value => !!value || "This field is required."
        }
      }
    };
  },
  mounted() {
    this.getDiseases();
  },
  methods: {
    getDiseases() {
      this.closeDialog();
      this.$store.commit("startLoading", "Fetching Diseases");
      Axios.get(
        "/api/diseases?token=" + this.$store.state.userData.access_token
      ).then(res => {
        console.log(res.data);
        this.diseases = res.data;
        this.$store.commit("stopLoading");
      });
    },
    addDescription() {
      this.disease.description.push({ name: "" });
    },
    edit(disease) {
      this.mode = "Edit";
      // let d = disease;
      console.log(disease);
      this.disease = disease;
      // d.description = JSON.parse(disease.description);
      if (this.IsJsonString(disease.description)) {
        this.disease.description = JSON.parse(disease.description);
        console.log("pass");
      } else {
        console.log("error");
      }
      this.dialog = true;
    },
    IsJsonString(str) {
      try {
        JSON.parse(str);
      } catch (e) {
        return false;
      }
      return true;
    },
    removeDescription(index) {
      if (this.disease.description.length > 1) {
        let description = [];
        for (let i = 0; i < this.disease.description.length; i++) {
          if (i != index) {
            description.push(this.disease.description[i]);
          }
        }
        this.disease.description = description;
      }
    },
    addDisease() {
      this.$store.commit("startLoading", "Adding new disease");
      Axios.post("/api/disease", this.disease).then(res => {
        console.log(res.data);
        this.dialog = false;
        this.getDiseases();
      });
    },
    update(id) {
      this.$store.commit("startLoading", "Updating Disease");
      Axios.patch("/api/disease/" + id, this.disease).then(res => {
        this.dialog = false;
        this.getDiseases();
      });
    },
    closeDialog() {
      this.dialog = false;
      this.mode = "Add";
      this.disease = {
        name: "",
        symptom: "",
        description: [{ name: "" }]
      };
    }
  }
};
</script>