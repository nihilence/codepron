CodePron.Views.PreviewsIndex = Backbone.CompositeView.extend({
  template:JST['previews/index'],
  initialize: function(){
    this.listenTo(this.collection, "sync", this.render);

  },

  render: function(){
    // debugger;

    var that = this;
    // console.log(CodePron.previews);
    this.renderPreviews();
    _(this.collection.each(function(preview){
        var content = that.template({preview: preview});
        that.$el.append(content);
    }))

      return this;
    },

    renderPreviews: function(){
      var that = this;
      -(CodePron.previews).each(function(preview){
        var subview = new CodePron.Views.PreviewShow({model:preview});
        that.addSubview('.iframe', subview)
        $('.index-frame').append(subview);
      })
      // console.log(CodePron.previews);
    }


});
