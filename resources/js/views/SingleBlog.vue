<template>
  <v-layout align-center justify-center row>
    <v-flex md8>
      <div class="blog" v-if="blog.id">
        <div>
          <div class="card">
            <div class="card-header">
              <div class="image">
                <img width="100%" :src="'/img/user.png'">
              </div>
              <div class="content">
                <strong>{{ blog.user.full_name }}</strong>
                <small class="pull-right">
                  <i class="menu-icon fa fa-clock-o"></i>
                  {{ getTime(blog.created_at)}}
                </small>
                <p class="header">{{ blog.header }}</p>
              </div>
            </div>
            <div class="card-body">{{ blog.body }}</div>
            <div class="card-footer pl-3 pr-3">
              <div class="comment" v-for="(comment, c) in blog.comments" :key="c">
                <div class="body">
                  <div class="image">
                    <img width="100%" :src="'/img/user.png'">
                  </div>
                  <div class="content">
                    <span>{{ comment.user.full_name }}</span>
                    <small class="pull-right">
                      <i class="menu-icon fa fa-clock-o"></i>
                      {{ getTime(comment.created_at)}}
                    </small>
                    <p>{{comment.body}}</p>
                  </div>
                </div>
                <hr>
              </div>
              <div class="composer">
                <input
                  type="text"
                  @keypress.enter="postComment()"
                  v-model="blog.comment"
                  name="composer"
                  placeholder="Comment ..."
                  class="form-control"
                  id="composer"
                >
              </div>
            </div>
          </div>
          <br>
        </div>
      </div>
    </v-flex>
  </v-layout>
</template>


<script>
import Axios from "axios";
import Moment from "moment";
export default {
  props: ["id"],
  data() {
    return {
      blog: []
    };
  },
  methods: {
    getBlog() {
      console.log(this.id);
      Axios.get("/api/blog/" + this.id).then(res => {
        this.blog = res.data;
      });
    },
    getTime(time) {
      return Moment.utc(time)
        .utcOffset(-3)
        .fromNow();
    },
    postComment() {
      let data = {
        user_id: this.user_id,
        blog_id: this.id,
        body: this.blog.comment
      };
      Axios.post("/api/comment", data).then(res => {
        if (res.data.comment == "created") {
          this.getBlog();
        }
      });
    }
  },
  mounted() {
    this.getBlog();
  },
  computed: {
    user_id() {
      return this.$store.state.userData.user.id;
    }
  }
};
</script>

<style lang="scss" scoped>
.blog {
  .card {
    border: 1px solid rgb(208, 236, 245);
    .card-header {
      text-decoration: none;
      color: rgb(82, 80, 80);
      padding: 3px 8px;

      display: flex;
      .image {
        min-width: 40px;
        min-height: 40px;
        max-height: 40px;
        max-width: 40px;
        border-radius: 20px;
        border: 1px solid rgb(201, 241, 247);
        flex: 1;
        margin-right: 5px;
        overflow: hidden;
      }
      .content {
        flex: 15;
        .header {
          margin: 0;
        }
        .pull-right {
          margin-top: 10px;
        }
      }
    }
    .card-body {
      padding: 10px 15px;
    }
    .card-footer {
      background-color: white;
      .comment {
        padding-top: 10px;
        hr {
          margin: 0;
          margin-bottom: 10px;
          border: 1px solid rgb(227, 248, 248);
        }
        .body {
          display: flex;
          .image {
            min-width: 40px;
            min-height: 40px;
            max-height: 40px;
            max-width: 40px;
            border-radius: 20px;
            border: 1px solid rgb(201, 241, 247);
            flex: 1;
            overflow: hidden;
          }
          .content {
            flex: 15;
          }
        }
      }
      .composer {
        input {
          height: 35px;
        }
      }
    }
  }
}
</style>