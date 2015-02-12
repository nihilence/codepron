CodePron.Collections.Follows = Backbone.Collection.extend({

  model: CodePron.Models.Follow,

  initialize: function(models, options){
    this.user = options.user;
  },

  url: 'api/follows',

  // getOrFetch: function(id){
  //     var follow = this.get(id);
  //     var follows = this;
  //
  //     if(follow){
  //       follow.fetch();
  //     } else {
  //       follow = new CodePron.Models.Follow({id:id});
  //       follow.fetch({
  //         success: function(){
  //           follows.add(follow);
  //         }
  //       });
  //     }
  //
  //     return follow;
  //   }
  // }

})
