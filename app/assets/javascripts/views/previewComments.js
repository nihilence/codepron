CodePron.Views.PreviewComments = Backbone.CompositeView.extend({

  template: JST['previews/previewComments'],

  events:{
    "click .submit":"saveComment"
  },

  initialize: function(){
    this.listenTo(this.collection, "add", this.addCommentView);
  },

  saveComment: function(event, comment){
    event.preventDefault();
    var that = this;
    var attrs = {body: $('#comment-body').val(),
    preview_id: this.model.get('id')};
    var options = {preview: this.model}
    var comment = new CodePron.Models.Comment(options);
    comment.set(attrs);
    comment.save({},
    {
      success: function(){
        that.collection.add(comment);
      }
    })
  },

  addCommentView: function(comment){
    var view = new CodePron.Views.CommentShow({model:comment,preview:this.model});
    this.addSubview('#comment-list', view);
  },


  renderComments: function(){
    var that = this;
    this.collection.forEach(function(comment){
      var view = new CodePron.Views.CommentShow({model:comment,preview:this.model});
      that.addSubview('#comment-list', view);
    })
  },

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    this.renderForm();
    this.renderComments();
    return this;
  },

  renderForm: function(){
    var view = new CodePron.Views.CommentForm({
              model:this.model,
              collection: this.collection
    })
    this.addSubview('#comment-form', view);
  },

});
