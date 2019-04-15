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
  <mdb-card>
    <mdb-card-body>
      <mdb-card-title>Basic card</mdb-card-title>
      <mdb-card-text>Some quick example text to build on the card title and make up the bulk of the card's content.</mdb-card-text>
      <mdb-btn color="primary">Button</mdb-btn>
    </mdb-card-body>
  </mdb-card>
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
        first:{
          title: '',
          desc: ''
        }
      }
    },

      methods: {
        add_first: function () {
        let data = {
                fId:"f123",
                name: this.name,
                symptom: this.symptom,
                exDisease: this.disease,
                solution: this.first
            }
            axios.post("http://localhost:3000/api/firstAids",data)
      }
    }
  }

</script>
