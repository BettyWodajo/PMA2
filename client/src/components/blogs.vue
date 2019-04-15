<template>
  <mdb-card>
    <mdb-card-body>
      <mdb-card-title>Basic card</mdb-card-title>
      <mdb-card-text>Some quick example text to build on the card title and make up the bulk of the card's content.</mdb-card-text>
      <mdb-btn color="primary">Button</mdb-btn>
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
