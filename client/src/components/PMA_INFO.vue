<template>
  <mdb-container>
    <mdb-tabs
      :active="0"
      default
      :links="[
        { text: 'FIRST AID' },
        { text: 'MEDICAL LIBRARY' }]"
      :content="[
        'test1',
        'test2'
      ]"
    />
  </mdb-container>

</template>
<script>

import {mdbContainer,mdbTabs} from 'mdbvue';
export default{
    name:'PMA_INFO',
    components: {
    mdbContainer,
    mdbTabs

  }

}
</script>
