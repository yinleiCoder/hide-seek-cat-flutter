/**
 * mock data: 聊天
 * @author yinlei
*/
class Chat {
  final String name, lastMessage, avatar_url, time;
  final bool isActive;

  Chat({
    this.name,
    this.lastMessage,
    this.avatar_url,
    this.time,
    this.isActive,
  });
}

List chatsData = [
  Chat(
    name: "王可尔",
    lastMessage: "Hope you are doing well...",
    avatar_url: "https://img.zcool.cn/community/0103a15d70b2b6a801202f17a508ee.jpg@1280w_1l_2o_100sh.jpg",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "张露丹",
    lastMessage: "Hello Abdullah! I am...",
    avatar_url: "https://img.zcool.cn/community/01cf615af10a56a801206abac5903f.jpg@1280w_1l_2o_100sh.jpg",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "张晓玲",
    lastMessage: "Do you have update...",
    avatar_url: "https://img.zcool.cn/community/01c7615a295059a80120ba38ef869c.jpg@1280w_1l_2o_100sh.jpg",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "赵晓梅",
    lastMessage: "You’re welcome :)",
    avatar_url: "https://img.zcool.cn/community/01bb865bbc1301a8012099c8c09eac.jpg@1280w_1l_2o_100sh.jpg",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "吴婷",
    lastMessage: "Thanks",
    avatar_url: "https://img.zcool.cn/community/01dbf75f36974ca80120a8214358d2.jpg@1280w_1l_2o_100sh.jpg",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "胡馨文",
    lastMessage: "Hope you are doing well...",
    avatar_url: "https://img.zcool.cn/community/0166935edcfb97a8012066213dc739.jpg@1280w_1l_2o_100sh.jpg",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: '陈爽(媳妇儿)',
   lastMessage: "Hello Abdullah! I am...",
    avatar_url: "https://img.zcool.cn/community/0166935edcfb97a8012066213dc739.jpg@1280w_1l_2o_100sh.jpg",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "明哥",
    lastMessage: "Do you have update...",
    avatar_url: "https://img.zcool.cn/community/010bba5f0890a6a801215aa00c8d22.jpg@1280w_1l_0o_100sh.jpg",
    time: "5d ago",
    isActive: false,
  ),
];
