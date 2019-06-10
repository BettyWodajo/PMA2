<template>
  <v-layout align-center justify-center row>
    <v-flex md8>
      <v-expansion-panel>
        <v-expansion-panel-content>
          <template v-slot:header>
            <div>New post</div>
          </template>
          <v-card>
            <v-card-text>
              <v-form>
                <v-flex xs12>
                  <v-text-field
                    label="Header"
                    v-model="b.header"
                    type="text"
                    :rules="[rules.required.required]"
                    :validate-on-blur="true"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-text-field
                    label="Body"
                    v-model="b.body"
                    type="text"
                    :rules="[rules.required.required]"
                    :validate-on-blur="true"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-text-field
                    label="Image (url)"
                    v-model="b.image"
                    type="text"
                    :rules="[rules.required.required]"
                    :validate-on-blur="true"
                  ></v-text-field>
                </v-flex>

                <v-btn color="primary" flat @click="post()">Post</v-btn>
              </v-form>
            </v-card-text>
          </v-card>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <br>
      <div class="blog" v-if="blog.length !== 0">
        <div v-for="(b, i) in blog" :key="i">
          <div class="card">
            <div class="card-header">
              <div class="image">
                <img width="100%" :src="'/img/user.png'">
              </div>
              <router-link :to="'/app/blog/' + b.id" class="content">
                <strong>{{ b.user.full_name }}</strong>
                <small class="pull-right">
                  <i class="menu-icon fa fa-clock-o"></i>
                  {{ getTime(b.created_at)}}
                </small>
                <p class="header">{{ b.header }}</p>
              </router-link>
                <v-spacer></v-spacer>
                <v-icon @click="removeBlog(b.id)">close</v-icon>
            </div>
            <div class="card-body">{{ b.body }}</div>
            <div class="card-footer pl-3 pr-3">
              <div class="comment" v-for="(comment, c) in b.comments" :key="c">
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
                <v-spacer></v-spacer>
                <v-icon @click="removeComment(comment.id)">close</v-icon>
                </div>
                <hr>
              </div>
              <div class="composer">
                <input
                  type="text"
                  @keypress.enter="postComment(i)"
                  v-model="b.comment"
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
  data() {
    return {
      blog: [],
      b: {
        header: "",
        body: "",
        image: ""
      },
      rules: {
        required: {
          required: value => !!value || "This field is required."
        }
      }
    };
  },
  methods: {
    getBlogs() {
      console.log(this.user_id);
      Axios.get("/api/blog").then(res => {
        this.blog = res.data;
        console.log(res.data);
      });
    },
    removeBlog(id) {
      Axios.delete("/api/blog/" + id).then(res => {
        this.getBlogs();
      });
    },
    removeComment(id) {
      Axios.delete("/api/comment/" + id).then(res => {
        this.getBlogs();
      });
    },
    getTime(time) {
      return Moment.utc(time)
        .utcOffset(-3)
        .fromNow();
    },
    postComment(index) {
      let data = {
        user_id: this.user_id,
        blog_id: this.blog[index].id,
        body: this.blog[index].comment
      };
      Axios.post("/api/comment", data).then(res => {
        if (res.data.comment == "created") {
          this.getBlogs();
        }
      });
    },
    post() {
      let post = this.b;
      post.user_id = this.user_id;
      Axios.post("/api/blog", post).then(res => {
        this.getBlogs();
      });
    }
  },
  mounted() {
    this.getBlogs();
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

