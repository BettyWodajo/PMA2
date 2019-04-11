
<template>
<div>
  <mdb-container>
    <mdb-row>
      <mdb-col size="12" class="text-center mb-5">
        <mdb-btn @click.native="showModal = true" color="info">ADD INFORMATION HERE </mdb-btn>
        <mdb-modal v-if="showModal" @close="showModal = false" cascade class="text-left">
          <mdb-modal-header class="primary-color white-text">
            <h4 class="title"> MEDICAL LIBRARY</h4>
          </mdb-modal-header>
          <mdb-modal-body class="grey-text">
            <mdb-input size="sm" label="disease id" icon="user" group type="text" validate error="wrong" success="right" v-model="disease_id"/>
            <mdb-input size="sm" label="disease name " icon="envelope" group type="email" validate error="wrong" success="right" v-model="name"/>
            <mdb-input size="sm" label="symptom" icon="tag" group type="text" validate error="wrong" success="right" v-model="symptom"/>
            <mdb-input size="sm" label="discription" icon="tag" group type="text" validate error="wrong" success="right" v-model="discription"/>

          </mdb-modal-body>
          <mdb-modal-footer>
            <mdb-btn color="secondary" @click.native="showModal = false">Close</mdb-btn>
            <mdb-btn color="primary" v-on:click= "addPost">Save changes</mdb-btn>
          </mdb-modal-footer>
        </mdb-modal>
      </mdb-col>
    </mdb-row>

  </mdb-container>
  </div>
  </div>
</template>

<script>
import axios from 'axios'
import main from './main'
import {mdbContainer, mdbRow, mdbCol, mdbInput, mdbTextarea, mdbBtn, mdbIcon, mdbModal, mdbModalHeader, mdbModalBody, mdbModalFooter } from 'mdbvue';
export default {
  name: 'medical_library',
  components: {
  medical_library,
    mdbContainer,
    mdbRow,
    mdbCol,
    mdbInput,
    mdbTextarea,
    mdbBtn,
    mdbIcon,
    mdbModal,
    mdbModalHeader,
    mdbModalBody,
    mdbModalFooter,
  },
  data() {
    return {
      showModal: false,
      }


  },
  mounted(){
  }
};
</script>

<style scoped>
</style>
