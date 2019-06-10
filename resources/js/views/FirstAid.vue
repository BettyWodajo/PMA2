<template>
  <v-card>
    <v-card-title>
      FirstAid
      <v-spacer></v-spacer>
      <v-btn @click="dialog = true" small>Add FirstAid</v-btn>
    </v-card-title>
    <v-card-text>
      <v-data-table :headers="headers" :items="firstAids" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.symptom }}</td>
          <td>
            <ul v-for="(description, i) in JSON.parse(props.item.description)" :key="i">
              <li>{{ description.name }}</li>
            </ul>
          </td>
          <td>{{props.item.disease.name}}</td>
          <td>
            <v-btn small fab @click="edit(props.item)">
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn @click="deleteFirstaid(props.item.id)" small fab>
              <v-icon>delete</v-icon>
            </v-btn>
          </td>
        </template>
      </v-data-table>
    </v-card-text>

    <!-- add dialog -->
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title class="grey lighten-2" primary-title>{{mode}} firstAid</v-card-title>
        <v-card-text>
          <v-form v-model="valid" ref="form" lazy-validation>
            <v-flex xs12>
              <v-text-field
                label="Symptom"
                v-model="firstAid.symptom"
                type="text"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
              ></v-text-field>
            </v-flex>
            <v-divider></v-divider>
            <v-flex>
              <h3>Descriptions</h3>
            </v-flex>
            <v-flex xs12 v-for="(description, i) in firstAid.description" :key="i">
              <v-text-field
                v-model="firstAid.description[i].name"
                type="text"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
                append-icon="remove"
                @click:append="removeDescription(i)"
              ></v-text-field>
            </v-flex>
            <v-btn @click="addDescription()">Add description</v-btn>
            <v-flex xs12>
              <v-select
                v-model="firstAid.disease_id"
                :items="diseases"
                label="Disease"
                item-text="name"
                :rules="[rules.required.required]"
                :validate-on-blur="true"
                item-value="id"
              ></v-select>
            </v-flex>
          </v-form>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error" flat @click="closeDialog()">Cancel</v-btn>
          <v-btn color="primary" v-if="mode == 'Add'" flat @click="addFirstAid()">Add</v-btn>
          <v-btn color="primary" v-if="mode == 'Edit'" flat @click="update(firstAid.id)">Update</v-btn>
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
      firstAidTemplate: {
        disease_id: null,
        symptom: "",
        description: [{ name: "" }]
      },
      firstAid: {
        disease_id: null,
        symptom: "",
        description: [{ name: "" }]
      },
      mode: "Add",
      valid: true,
      dialog: false,
      headers: [
        { text: "Symptom", value: "symptom" },
        { text: "Description", value: "description" },
        { text: "Disease", value: "disease" },
        { text: "Actions", value: "actions" }
      ],
      diseases: [],
      firstAids: [],
      rules: {
        required: {
          required: value => !!value || "This field is required."
        }
      }
    };
  },
  mounted() {
    this.getFirstAids();
  },
  methods: {
    getFirstAids() {
      this.closeDialog();
      this.$store.commit("startLoading", "Fetching First aids");
      Axios.get(
        "/api/firstAid?token=" + this.$store.state.userData.access_token
      ).then(res => {
        console.log(res.data);
        this.firstAids = res.data;
        this.getDiseases();
      });
    },
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
      this.firstAid.description.push({ name: "" });
    },
    edit(firstAid) {
      this.mode = "Edit";
      this.firstAid = firstAid;
      if (this.IsJsonString(firstAid.description)) {
        this.firstAid.description = JSON.parse(firstAid.description);
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
      if (this.firstAid.description.length > 1) {
        let description = [];
        for (let i = 0; i < this.firstAid.description.length; i++) {
          if (i != index) {
            description.push(this.firstAid.description[i]);
          }
        }
        this.firstAid.description = description;
      }
    },
    addFirstAid() {
      this.$store.commit("startLoading", "Adding new first aid");
      Axios.post("/api/firstAid", this.firstAid).then(res => {
        this.dialog = false;
        this.getFirstAids();
      });
    },
    update(id) {
      this.$store.commit("startLoading", "Updating FirstAid");
      Axios.patch("/api/firstAid/" + id, this.firstAid).then(res => {
        this.dialog = false;
        this.getFirstAids();
      });
    },
    closeDialog() {
      this.dialog = false;
      this.mode = "Add";
      this.firstAid = this.firstAidTemplate;
    },
    deleteFirstaid(id) {
      this.$store.commit("startLoading", "Removing FirstAid");
      Axios.delete("/api/firstAid/" + id).then(res => {
        this.getFirstAids();
      });
    }
  }
};
</script>