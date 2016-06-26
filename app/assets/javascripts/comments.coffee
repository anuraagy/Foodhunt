# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Comments
  constructor: (@element) ->
    @document            = $(document)

    @errors              = @element.find(".notice")
    @comment_form        = @element.find("#comment_form")
    @comment_submit      = @element.find("#comment_submit")
    @comments_container  = @element.find(".comments")

    @comments_container.on "ajax:error", @comment_form, @errorComment


  errorComment: =>
    @errors.html("Unfortunatly there was an error in your comment, please try again next time")
    @errors.show()

$ ->
  new Comments($("body"))
