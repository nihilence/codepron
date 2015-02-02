PronTest.Views.PreviewShow = Backbone.View.extend({
  template: JST['previews/previewShow'],

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    // this.renderForm();
    this.$iframe = $('#main').append('<iframe class="iframe"></iframe>')
    $('.iframe').contents().find('body').html(this.template({preview: this.model}));

    return this;
  },

  renderForm: function(){
    var formView = new PronTest.Views.PreviewForm({model: this.model});
    return this;
  }

});
