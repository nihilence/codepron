CodePron.Views.PreviewShow = Backbone.CompositeView.extend({
  template: JST['previews/previewShow'],

  initialize: function(){
    this.listenTo(this.model, "change", this.render);
  },

  render: function(){
    var content = this.template({preview: this.model})
    this.$el.html(content);
    this.renderForm();
    this.renderIframe();
    return this;
  },

  renderForm: function () {
    var view = new CodePron.Views.PreviewForm({
      model: this.model
    });
    this.addSubview('#preview-form', view);
  },

  renderIframe: function(){
    var view = new CodePron.Views.IframeShow({
      model: this.model
    })

    this.addSubview('#preview-iframe', view)
  }


});
