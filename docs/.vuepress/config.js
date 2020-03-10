/**
 * @see https://vuepress.vuejs.org/zh/
 */
module.exports = {
  port: "4000",
  dest: "dist",
  base: "/linux-tutorial/",
  title: "LINUX-TUTORIAL",
  description: "数据库教程",
  head: [["link", {rel: "icon", href: `/favicon.ico`}]],
  markdown: {
    externalLinks: {
      target: "_blank", rel: "noopener noreferrer"
    }
  },
  themeConfig: {
    logo: "images/dunwu-logo-100.png",
    repo: "dunwu/linux-tutorial",
    repoLabel: "Github",
    editLinks: true,
    smoothScroll: true,
    locales: {
      "/": {
        label: "简体中文", selectText: "Languages", editLinkText: "帮助我们改善此页面！", lastUpdated: "上次更新", nav: [{
          text: "Linux 命令", link: "/linux/cli/",
        }, {
          text: "Linux 运维", link: "/linux/ops/",
        }, {
          text: "Linux 软件运维", link: "/linux/soft/",
        }, {
          text: "Docker 教程", link: "/docker/",
        }, {
          text: "🎯 博客", link: "https://github.com/dunwu/blog", target: "_blank", rel: ""
        }], sidebar: "auto", sidebarDepth: 2
      }
    }
  },
  plugins: [["@vuepress/back-to-top", true], ["@vuepress/pwa", {
    serviceWorker: true, updatePopup: true
  }], ["@vuepress/medium-zoom", true], ["container", {
    type: "vue", before: '<pre class="vue-container"><code>', after: "</code></pre>"
  }], ["container", {
    type: "upgrade", before: info => `<UpgradePath title="${info}">`, after: "</UpgradePath>"
  }], ["flowchart"]]
};
