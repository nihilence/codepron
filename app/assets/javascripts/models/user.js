CodePron.Models.User = Backbone.Model.extend({
  urlRoot: '/api/users',

  previews: function () {
    if (!this._previews) {
      this._previews = new CodePron.Collections.Previews([]);
    }
    return this._previews;
  },

  follow: function(){

    var follow = new CodePron.Models.Follow()

    var options = {
      follower_id: currentUser,
      followed_id: this.id
    };

    var that = this;
    follow.save( options, {
      success: function(){
        var currUserModel = CodePron.users.get(currentUser);
        that.followers().add(follow);
        that.follows().add(follow);
        currUserModel.followedUsers().add(follow);
        that.set('is_followed', true);
      }
    })

  },

  unfollow: function(){
    var that = this;
    var currUserModel = CodePron.users.get(currentUser);
    var follow= function(){ return that.follows().where({follower_id: currentUser});}
    follow()[0].fetch({
      success: function(){
        follower = CodePron.users.get(currentUser)
        that.followers().remove(follower);
        follow()[0].destroy();
        that.set('is_followed',false);

      }
    });
    // follow.destroy();
  },

  parse: function (response) {
    if (response.followers){
      this.followers().set(response.followers);
      delete response.followers;
    }

    if (response.previews) {
      this.previews().set(response.previews, { parse: true });
      delete response.previews;
    }

    if (response.followed_users){
      // this._followedUsers = response.followed_users;
      this.followedUsers().set(response.followed_users);
      delete response.followed_users;
    }

    if(response.follows){
      this.follows().set(response.follows);
      delete response.follows;
    }

    return response;
  },

  followers: function(){
    if (!this._followers) {
      this._followers = new CodePron.Collections.Follows([], {user: this});
    }
    return this._followers;
  },

  followedUsers: function(){
    if (!this._followed_users) {
      this._followed_users = new CodePron.Collections.Follows([], {user: this});
    }
    return this._followed_users;
  },

  follows: function(){
    if(!this._follows){
      this._follows = new CodePron.Collections.Follows([], {user:this})
    }

    return this._follows;
  }

})
