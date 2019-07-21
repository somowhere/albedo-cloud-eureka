<template>
  <div class="top-menuEntity">
    <el-menuEntity :default-active="activeIndex"
             mode="horizontal"
             text-color="#333">
      <template v-for="(item,index) in items">
        <el-menuEntity-item :index="item.parentId+''"
                      @click.native="openMenu(item)"
                      :key="index">
          <template slot="title">
            <i :class="item.icon"></i>
            <span>{{item.label}}</span>
          </template>
        </el-menuEntity-item>
      </template>
    </el-menuEntity>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "top-menuEntity",
  data() {
    return {
      activeIndex: "0",
      items: []
    };
  },
  created() {
  },
  computed: {
    ...mapGetters(["tagCurrent", "menuEntity"])
  },
  methods: {
    openMenu(item) {
      this.$store.dispatch("GetMenu", item.parentId).then(data => {
        if (data.length !== 0) {
          this.$router.$avueRouter.formatRoutes(data, true);
        }
        let itemActive,
          childItemActive = 0;
        if (item.path) {
          itemActive = item;
        } else {
          if (this.menuEntity[childItemActive].length == 0) {
            itemActive = this.menuEntity[childItemActive];
          } else {
            itemActive = this.menuEntity[childItemActive].children[childItemActive];
          }
        }
        this.$router.push({
          path: this.$router.$avueRouter.getPath({
            name: itemActive.label,
            src: itemActive.path
          })
        });
      });
    }
  }
};
</script>
