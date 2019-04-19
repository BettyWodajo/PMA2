<template>

        <GridLayout rows="*" height="1500px">
        <RadSideDrawer ref="drawer">
            <StackLayout ~drawerContent backgroundColor="gray">
                <StackLayout height="56" style="text-align: center; vertical-align: center;">
                    <Label text="Navigation Menu" />
                </StackLayout>
                <StackLayout>
                    <Label text="Primary" padding="10" backgroundColor="lightgray" />
                    <Label text="Social" padding="10" />
                    <Label text="Promotions" padding="10" />
                    <Label text="Labels" padding="10" backgroundColor="lightgray" />
                    <Label text="Important" padding="10" />
                    <Label text="Starred" padding="10" />
                    <Label text="Sent Mail" padding="10" />
                    <Label text="Drafts" padding="10" />
                </StackLayout>
                <Label text="Close" color="lightgray" padding="10" style="horizontal-align: center"
                    @tap="onCloseDrawerTap" />
            </StackLayout>
            <StackLayout ~mainContent>
                <Label :text="mainContentText" textWrap="true" fontSize="13"
                    padding="10" />
                <Button text="Open Drawer" @tap="onOpenDrawerTap" margin="10"
                    style="horizontal-align: left" />
            </StackLayout>
        </RadSideDrawer>
        </GridLayout>
    
</template>

<script >
  export default {
    data() {
      return {
        msg: 'Hello World!'
      }
    }
  }
</script>

<style scoped>
    ActionBar {
        background-color: #53ba82;
        color: #ffffff;
    }

    .message {
        vertical-align: center;
        text-align: center;
        font-size: 20;
        color: #333333;
    }
</style>
