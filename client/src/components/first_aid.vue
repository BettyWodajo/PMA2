<template>
  <div>
  <mdb-container>
    <mdb-row>
      <mdb-col size="12" class="text-center mb-5">
        <mdb-btn @click.native="showModal = true" color="info">ADD NEW</mdb-btn>
        <mdb-modal :show="showModal" @close="showModal = false" cascade class="text-left">
          <mdb-modal-header class="primary-color white-text">
            <h4 class="title"><fa class="fas fa-pencil-alt" /> first aid</h4>
          </mdb-modal-header>
          <mdb-modal-body class="grey-text">
            <mdb-input size="sm" label=" NAME" icon="pencil" group type="text" validate error="wrong" success="right" v-model="name"/>
            <mdb-input size="sm" label="SYMPTOM" icon="pencil" group type="email" validate error="wrong" success="right" v-model="symptom"/>
            <mdb-input size="sm" label="EXPECTED DISEASE" icon="pencil" group type="text" validate error="wrong" success="right" v-model="disease"/>
            <mdb-col>
            <mdb-input size="sm" label="Step Name" icon="pencil" group type="text" validate error="wrong" success="right" v-model="first.title"/>
            <mdb-textarea size="sm" :rows="2" label="SOLUTION" icon="pencil" v-model="first.desc"/>
          </mdb-col>
          </mdb-modal-body>
          <mdb-modal-footer>
            <mdb-btn color="secondary" @click.native="showModal = false">Close</mdb-btn>
            <mdb-btn color="primary" @click="add_first">Save changes</mdb-btn>
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
      <mdb-card-text>{{d.exDisease}}</mdb-card-text>
      <mdb-card-text>{{d.solution.title}}</mdb-card-text>
      <mdb-card-text>{{d.solution.desc}}</mdb-card-text>
      <mdb-btn color="primary">Edit</mdb-btn>
      <mdb-btn color="danger">Delete</mdb-btn>
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
      mdbModalFooter,
      mdbContainer
    },
    data() {
      return {
        showModal: false,
        first:{
          title: '',
          desc: ''
        },
        detail:[],
        firstAid: {
          name:'',
          symptom: '',
          disease: '',
        }
      }
    },
    mounted(){
  // this.add_first()
  this.getFirst()


  },

      methods: {
        add_first: function () {
        let data = {
                fId:"f123",
                name: this.firstAid.name,
                symptom: this.firstAid.symptom,
                exDisease: this.firstAid.disease,
                solution: this.first
            }
            axios.post('http://localhost:3000/api/firstaids',data).then(response =>{
    console.log(response)
  }).catch(err => {
    console.log(err);
  })
      },
      getFirst: function() {
        axios.get('http://localhost:3000/api/firstaids').then(response =>{
    this.detail = response.data
    response.data.reverse() 
    console.log(response.data) 
    })
  }
      }
  }
</script>
