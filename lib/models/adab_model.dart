// To parse this JSON data, do
//
//     final newsFeedResponse = newsFeedResponseFromJson(jsonString);

class NewsFeedResponse {
  NewsFeedResponse({
    this.success,
    this.results,
    this.errors,
    this.meta,
  });

  bool success;
  List<NewsFeedResponseDatum> results;
  dynamic errors;
  NewsFeedResponseMeta meta;

  NewsFeedResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      results = new List<NewsFeedResponseDatum>();
      json['data'].forEach((v) {
        results.add(new NewsFeedResponseDatum.fromJson(v));
      });
    }
    errors = json['errors'];
    meta = NewsFeedResponseMeta.fromJson(json['meta']);
  } //=> NewsFeedResponse(

  //);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datas = new Map<String, dynamic>();
    datas['success'] = this.success;
    if (this.results != null) {
      datas['data'] = List<dynamic>.from(results.map((x) => x.toJson()));
    }

    datas['errors'] = this.errors;
    datas['meta'] = this.meta.toJson();
    return datas;
  }
}

class NewsFeedResponseDatum {
  NewsFeedResponseDatum({
    this.id,
    this.slug,
    this.content,
    this.metaUrl,
    this.hasReacted,
    this.yourReaction,
    this.permission,
    this.taggedUser,
    this.media,
    this.postOwner,
    this.accountOwner,
    this.reaction,
    this.comment,
    this.createdAt,
  });

  int id;
  String slug;
  String content;
  dynamic metaUrl;
  bool hasReacted;
  dynamic yourReaction;
  Permission permission;
  List<TaggedUser> taggedUser;
  //List<dynamic> taggedUser;
  List<Media> media;
  TOwner postOwner;
  TOwner accountOwner;
  FluffyReaction reaction;
  CommentClass comment;
  DateTime createdAt;

  NewsFeedResponseDatum.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    slug = json['slug'] == null ? null : json['slug'];
    content = json['content'] == null ? null : json['content'];
    metaUrl = json['meta_url'];
    hasReacted = json['has_reacted'] == null ? null : json['has_reacted'];
    yourReaction = json['your_reaction'];
    permission = json['permission'] == null
        ? null
        : Permission.fromJson(json['permission']);
    taggedUser = List<TaggedUser>.from(
        json["tagged_user"].map((x) => TaggedUser.fromJson(x)));
    // taggedUser = json['tagged_user'] == null
    //     ? null
    //     : List<dynamic>.from(json['tagged_user'].map((x) => x));
    media = json['media'] == null
        ? null
        : List<Media>.from(json['media'].map((x) => Media.fromJson(x)));
    postOwner =
        json['post_owner'] == null ? null : TOwner.fromJson(json['post_owner']);
    accountOwner = json['account_owner'] == null
        ? null
        : TOwner.fromJson(json['account_owner']);
    reaction = json['reaction'] == null
        ? null
        : FluffyReaction.fromJson(json['reaction']);
    //comment = json['comment'];
    comment =
        json['comment'].isEmpty ? null : CommentClass.fromJson(json['comment']);
    createdAt =
        json['created_at'] == null ? null : DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id == null ? null : id;
    data['slug'] = slug == null ? null : slug;
    data['content'] = content == null ? null : content;
    data['meta_url'] = metaUrl;
    data['has_reacted'] = hasReacted == null ? null : hasReacted;
    data['your_reaction'] = yourReaction;
    data['permission'] = permission == null ? null : permission.toJson();
    data['tagged_user'] = List<dynamic>.from(taggedUser.map((x) => x.toJson()));
    // data['tagged_user'] = taggedUser == null
    //     ? null
    //     : List<dynamic>.from(taggedUser.map((x) => x));
    data['media'] =
        media == null ? null : List<dynamic>.from(media.map((x) => x.toJson()));
    data['post_owner'] = postOwner == null ? null : postOwner.toJson();
    data['account_owner'] = accountOwner == null ? null : accountOwner.toJson();
    data['reaction'] = reaction == null ? null : reaction.toJson();
    data['comment'] = comment.toJson();
    data['created_at'] = createdAt == null ? null : createdAt.toIso8601String();
    return data;
  }
}

class TaggedUser {
  TaggedUser({
    this.userTagId,
    this.userTaggableType,
    this.userId,
    this.username,
    this.fullname,
    this.avatar,
  });

  int userTagId;
  String userTaggableType;
  int userId;
  String username;
  String fullname;
  String avatar;

  factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
        userTagId: json["user_tag_id"],
        userTaggableType: json["user_taggable_type"],
        userId: json["user_id"],
        username: json['username'],
        fullname: json['fullname'],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "user_tag_id": userTagId,
        "user_taggable_type": userTaggableType,
        "user_id": userId,
        "username": username,
        "fullname": fullname,
        "avatar": avatar,
      };
}

class TOwner {
  TOwner({
    this.id,
    this.username,
    this.fullname,
    this.avatar,
    this.userId,
  });

  int id;
  String username;
  String fullname;
  String avatar;
  int userId;

  TOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    username = json['username'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    userId = json['user_id'] == null ? null : json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id == null ? null : id;
    data['username'] = username;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['user_id'] = userId == null ? null : userId;
    return data;
  }
}

class CommentClass {
  CommentClass({
    this.data,
    this.meta,
  });

  List<CommentDatum> data;
  CommentMeta meta;

  CommentClass.fromJson(Map<String, dynamic> json) {
    data = List<CommentDatum>.from(
        json['data'].map((x) => CommentDatum.fromJson(x)));
    meta = CommentMeta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datas = new Map<String, dynamic>();
    datas['data'] = List<dynamic>.from(data.map((x) => x.toJson()));
    datas['meta'] = meta.toJson();
    return datas;
  }
}

class CommentDatum {
  CommentDatum({
    this.id,
    this.parentId,
    this.userId,
    this.content,
    this.metaUrl,
    this.commentableType,
    this.commentableId,
    this.hasReacted,
    this.yourReaction,
    this.createdAt,
    this.commentOwner,
    this.taggedUser,
    this.media,
    this.reply,
    this.reaction,
  });

  int id;
  dynamic parentId;
  int userId;
  String content;
  dynamic metaUrl;
  String commentableType;
  int commentableId;
  bool hasReacted;
  dynamic yourReaction;
  DateTime createdAt;
  TOwner commentOwner;
  List<dynamic> taggedUser;
  List<dynamic> media;
  List<dynamic> reply;
  PurpleReaction reaction;

  CommentDatum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    userId = json['user_id'];
    content = json['content'];
    metaUrl = json['meta_url'];
    commentableType = json['commentable_type'];
    commentableId = json['commentable_id'];
    hasReacted = json['has_reacted'];
    yourReaction = json['your_reaction'];
    createdAt = DateTime.parse(json['created_at']);
    commentOwner = TOwner.fromJson(json['comment_owner']);
    taggedUser = List<dynamic>.from(json['tagged_user'].map((x) => x));
    media = List<dynamic>.from(json['media'].map((x) => x));
    reply = List<dynamic>.from(json['reply'].map((x) => x));
    // reaction = json['reaction'] == null
    //     ? null
    //     : PurpleReaction.fromJson(json['reaction']);
    reaction = PurpleReaction.fromJson(json['reaction']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['parent_id'] = parentId;
    data['user_id'] = userId;
    data['content'] = content;
    data['meta_url'] = metaUrl;
    data['commentable_type'] = commentableType;
    data['commentable_id'] = commentableId;
    data['has_reacted'] = hasReacted;
    data['your_reaction'] = yourReaction;
    data['created_at'] = createdAt.toIso8601String();
    data['comment_owner'] = commentOwner.toJson();
    data['tagged_user'] = List<dynamic>.from(taggedUser.map((x) => x));
    data['media'] = List<dynamic>.from(media.map((x) => x));
    data['reply'] = List<dynamic>.from(reply.map((x) => x));
    data['reaction'] = reaction.toJson();
    return data;
  }
}

class PurpleReaction {
  PurpleReaction({
    this.total,
    this.data,
  });

  int total;
  DataClass data;

  PurpleReaction.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    data = json['data'].isEmpty ? null : DataClass.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datas = new Map<String, dynamic>();
    datas['total'] = total;
    datas['data'] = data.toJson();
    return datas;
  }
}

class CommentMeta {
  CommentMeta({
    this.link,
    this.page,
  });

  Link link;
  Page page;

  CommentMeta.fromJson(Map<String, dynamic> json) {
    link = Link.fromJson(json['link']);
    page = Page.fromJson(json['page']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = link.toJson();
    data['page'] = page.toJson();
    return data;
  }
}

class Link {
  Link({
    this.first,
    this.prev,
    this.next,
    this.last,
  });

  String first;
  dynamic prev;
  String next;
  String last;

  Link.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    prev = json['prev'];
    next = json['next'] == null ? null : json['next'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = first;
    data['prev'] = prev;
    data['next'] = next == null ? null : next;
    data['last'] = last;
    return data;
  }
}

class Page {
  Page({
    this.current,
    this.last,
    this.perPage,
    this.item,
  });

  int current;
  int last;
  int perPage;
  Item item;

  Page.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    last = json['last'];
    perPage = json['perPage'];
    item = Item.fromJson(json['item']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = current;
    data['last'] = last;
    data['perPage'] = perPage;
    data['item'] = item.toJson();
    return data;
  }
}

class Item {
  Item({
    this.all,
    this.perPage,
  });

  int all;
  int perPage;

  Item.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = all;
    data['perPage'] = perPage;
    return data;
  }
}

class Media {
  Media({
    this.id,
    this.url,
  });

  int id;
  String url;

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Permission {
  Permission({
    this.id,
    this.type,
    this.description,
  });

  int id;
  String type;
  String description;

  Permission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}

class FluffyReaction {
  FluffyReaction({
    this.total,
    this.data,
  });

  int total;
  DataClass data;

  factory FluffyReaction.fromJson(Map<String, dynamic> json) => FluffyReaction(
        total: json['total'],
        data: json['data'].isEmpty ? null : DataClass.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'data': data.toJson(),
      };
}

class DataClass {
  DataClass({
    this.all,
    this.like,
  });

  List<All> all;
  Like like;

  DataClass.fromJson(Map<String, dynamic> json) {
    all = List<All>.from(json['all'].map((x) => All.fromJson(x)));
    like = Like.fromJson(json['like']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = List<dynamic>.from(all.map((x) => x.toJson()));
    data['like'] = like.toJson();
    return data;
  }
}

class All {
  All({
    this.id,
    this.user,
    this.type,
    this.target,
    this.createdAt,
  });

  int id;
  User user;
  Type type;
  Target target;
  DateTime createdAt;

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = User.fromJson(json['user']);
    type = Type.fromJson(json['type']);
    target = Target.fromJson(json['target']);
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user.toJson();
    data['type'] = type.toJson();
    data['target'] = target.toJson();
    data['created_at'] = createdAt.toIso8601String();
    return data;
  }
}

class Target {
  Target({
    this.id,
    this.type,
    this.content,
    this.slug,
  });

  int id;
  String type;
  String content;
  String slug;

  Target.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['content'] = content;
    data['slug'] = slug;
    return data;
  }
}

class Type {
  Type({
    this.id,
    this.name,
    this.description,
  });

  int id;
  String name;
  String description;

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class User {
  User({
    this.id,
    this.username,
    this.fullname,
    this.avatar,
    this.relationship,
    this.invitation,
  });

  int id;
  String username;
  String fullname;
  String avatar;
  dynamic relationship;
  List<dynamic> invitation;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    relationship = json['relationship'];
    invitation = List<dynamic>.from(json['invitation'].map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['relationship'] = relationship;
    data['invitation'] = List<dynamic>.from(invitation.map((x) => x));
    return data;
  }
}

class Like {
  Like({
    this.total,
    this.reaction,
  });

  int total;
  List<All> reaction;

  Like.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    reaction = List<All>.from(json['reaction'].map((x) => All.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['reaction'] = List<dynamic>.from(reaction.map((x) => x.toJson()));
    return data;
  }
}

class NewsFeedResponseMeta {
  NewsFeedResponseMeta({
    this.link,
    this.page,
    this.timestamp,
    this.timezone,
  });

  Link link;
  Page page;
  String timestamp;
  String timezone;

  NewsFeedResponseMeta.fromJson(Map<String, dynamic> json) {
    link = Link.fromJson(json['link']);
    page = Page.fromJson(json['page']);
    timestamp = json['timestamp'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = link.toJson();
    data['page'] = page.toJson();
    data['timestamp'] = timestamp;
    data['timezone'] = timezone;
    return data;
  }
}
