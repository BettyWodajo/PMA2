<template>
  <div>
  <mdb-container>
    <mdb-row>
      <mdb-col size="12" class="text-center mb-5">
        <mdb-btn @click.native="showModal = true" color="info">Add New</mdb-btn>
        <mdb-modal :show="showModal" @close="showModal = false" cascade class="text-left">
          <mdb-modal-header class="primary-color white-text">
            <h4 class="title"><fa class="fas fa-pencil-alt" /> Medical Library</h4>
          </mdb-modal-header>
          <mdb-modal-body class="grey-text">
            <mdb-input size="sm" label="Disease name" icon="pencil" group type="text" validate error="wrong" success="right" v-model="Dname"/>
            <mdb-input size="sm" label="Symptom" icon="pencil" group type="email" validate error="wrong" success="right" v-model="symptom"/>
            <mdb-input size="sm" label="Title" icon="pencil" group type="text" validate error="wrong" success="right" v-model="med.title"/>
            <mdb-textarea size="sm" :rows="2" label="Description" icon="pencil" v-model="med.desc"/>
            <mdb-btn color="primary">Add Another</mdb-btn>
          </mdb-modal-body>
          <mdb-modal-footer>
            <mdb-btn color="secondary" @click.native="showModal = false">Close</mdb-btn>
            <mdb-btn color="primary" @click="addDisease">Save changes</mdb-btn>
          </mdb-modal-footer>
        </mdb-modal>
      </mdb-col>
    </mdb-row>
  </mdb-container>
  <mdb-container>
    <mdb-row >
      <mdb-col col="sm" v-for="d in detail">
  <mdb-card>
    <mdb-card-image src="" alt=""></mdb-card-image>
    <mdb-card-body>
      <mdb-card-title>{{d.name}}</mdb-card-title>
      <mdb-card-text>{{d.symptom}}</mdb-card-text>
      <mdb-card-text>{{d.description.title}}</mdb-card-text>
      <mdb-card-text>{{d.description.desc}}</mdb-card-text>
      <mdb-btn color="primary">Edit</mdb-btn>
      <mdb-btn color="danger" @click="deleteDisease(d.id)">Delete</mdb-btn>
    </mdb-card-body>
  </mdb-card>
</mdb-col>
    </mdb-row>
  </mdb-container>
</div>
</template>
<script>
import axios from "axios"
  import { mdbCard, mdbCardImage, mdbCardBody, mdbCardTitle, mdbCardText,mdbContainer, mdbRow, mdbCol, mdbInput, mdbTextarea, mdbBtn, mdbIcon, mdbModal, mdbModalHeader, mdbModalBody, mdbModalFooter } from 'mdbvue';
  export default {
    name: 'first_aid',
    components: {
      mdbCard,
      mdbCardImage,
      mdbCardBody,
      mdbCardTitle,
      mdbCardText,
      mdbBtn,
      mdbRow,
      mdbCol,
      mdbInput,
      mdbTextarea,
      mdbIcon,
      mdbModal,
      mdbModalHeader,
      mdbModalBody,
      mdbModalFooter
    },
    data() {
      return {
        showModal: false,
        med:{
          title: '',
          desc: ''
        },
        detail:[]
      }
    },
    mounted(){
      this.getDisease()
      this.deleteDisease()
    },

      methods: {
        addDisease: function () {
        let data = {
                dId:"d123",
                name: this.Dname,
                symptom: this.symptom,
                description: this.med,
                
            }
            axios.post("http://localhost:3000/api/diseases",data)
      },
      getDisease: function () {
         axios.get('http://localhost:3000/api/diseases').then(response =>{
    this.detail = response.data
    response.data.reverse() 
    console.log(response.data) 
    })

      },
      deleteDisease(id){
      axios.delete('http://localhost:3000/api/diseases/'+id)
                .then(response => {
              this.getDisease()
                });
                console.log(this.result);
      }
    }
  }

</script>
