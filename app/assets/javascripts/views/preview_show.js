CodePron.Views.PreviewShow = Backbone.CompositeView.extend({
  template: JST['previews/showPreview'],

  events:{
    "click #comments":"popUp",
    "click #comments.open":"popDown",
    "click #info":"infoUp",
    "click #info.open": "infoDown",
    "click #save-details" : "saveDetails"
  },

  initialize: function(){
    this.collection = this.model.comments();
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
  },

  popUp: function (event){
    event.preventDefault();
    $('.comment-popup').addClass('active');
    $('#comments').addClass('open');
    var view = new CodePron.Views.PreviewComments({model: this.model,
      collection: this.collection})
    this.addSubview('.comment-popup', view)
  },

  popDown: function(event){
    event.preventDefault();
    $('.comment-popup').removeClass('active');
    $('#comments').removeClass('open');
    var that = this;
    this.subviews()['.comment-popup'].forEach(function(view){
      that.removeSubview('.comment-popup', view);

    })
    that.render();
  },

  infoUp:function(event){
      event.preventDefault();
      $('.info-popup').addClass('active');
      $('#info').addClass('open');
      var view = new CodePron.Views.InfoForm({model: this.model})
        this.addSubview('.info-popup', view)
  },

  infoDown:function(){
    $('.info-popup').removeClass('active');
    $('#info').removeClass('open');
    var that = this;
    this.subviews()['.info-popup'].forEach(function(view){
      that.removeSubview('.info-popup', view);

    })
    that.render();
  },

  saveDetails: function(event){
    var that = this;
    event.preventDefault();
    var attrs = {
      title:$('#pen-details-title').val(),
      description: $('#pen-details-description').val()
    }
    this.model.set(attrs)
    this.model.save({},
      {
        success: function(){
          that.infoDown();
        }
      })
  }


});
