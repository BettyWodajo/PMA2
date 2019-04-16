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
  <mdbContainer>
  <div class="row">

                    <!--Grid column-->
                    <div class="col-lg-4 mb-4">
                        <!--Featured image-->
                        <div class="view overlay z-depth-1">
                            <img src="https://mdbootstrap.com/img/Photos/Others/img (35).jpg" class="img-fluid" alt="Third sample image">
                            <a>
                                <div class="mask rgba-white-slight"></div>
                            </a>
                        </div>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-7 mb-4">
                        <!--Excerpt-->
                        <a href="" class="brown-text"><h6 class="pb-1"><i class="fa fa-camera"></i><strong> Photography</strong></h6></a>
                        <h4 class="mb-4"><strong>This is title of the news</strong></h4>
                        <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.</p>
                        <p>by <a><strong>Jessica Clark</strong></a>, 21/08/2016</p>
                        <a class="btn btn-primary">Read more</a>
                    </div>
                    <!--Grid column-->

                </div>
                </mdbContainer>
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
        }
      }
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
      }
    }
  }

</script>
