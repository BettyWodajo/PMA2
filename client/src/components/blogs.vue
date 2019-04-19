<template>
  <mdb-card>
    <mdb-card-body>
      <mdb-card-title>blogs</mdb-card-title>
      <mdb-card-text>A health blog can cover diverse health related concerns such as nutrition and diet, fitness, weight control, diseases, disease management, societal trends affecting health, analysis about health, business of health and health research.
It acts as a health education platform, where diverse users collaborate to seek and/or contribute health content within the standard guidelines. Although it is not a requirement, a health blog can be interactive, engaging and collaborative with its users in the creation of content.A health blog can grow in user size and operate as an online community.</mdb-card-text>
      <mdb-btn color="danger">Delete</mdb-btn>
    </mdb-card-body>
  </mdb-card>
</template>
<script>
  import { mdbCard, mdbCardImage, mdbCardBody, mdbCardTitle, mdbCardText, mdbBtn } from 'mdbvue';
  export default {
    name: 'CardPage',
    components: {
      mdbCard,
      mdbCardImage,
      mdbCardBody,
      mdbCardTitle,
      mdbCardText,
      mdbBtn
    }
  }
</script>
