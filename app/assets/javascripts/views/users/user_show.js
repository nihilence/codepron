CodePron.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['users/show'],

  events: {
    "click button" : "toggleFollow",
    // "click .followed": "unfollowUser"
  },

  initialize: function(){
    this.collection = this.model.previews();
    this.followers = this.model.followers();
    this.listenTo(this.model, "sync", this.render);
    this.userInfoView = new CodePron.Views.UserInfo({
      model: this.model
    });

  },
  toggleFollow: function(event){
    event.preventDefault();
    if(this.model.get('is_followed')){
      this.model.unfollow();
    } else {
      this.model.follow();
    }
  },

  render: function(){
    var content = this.template({user: this.model})
    this.$el.html(content);
    this.$('#info-tab').html(this.userInfoView.render().$el);
    this.renderIframes();
    $('.prev-page').remove()
    $('.next-page').remove()
    return this;
  },

  renderIframes: function(){
    var view = new CodePron.Views.PreviewsIndex({collection:this.model.previews()})
    this.addSubview("#previews-tab", view);
  },


    unfollowUser: function(){
      var currUserModel = CodePron.users.get(currentUser);
      debugger;
      // var follow = this.followers.where({follower_id: currUserModel.id})

    }



});
