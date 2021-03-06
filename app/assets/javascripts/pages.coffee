class Pages
  constructor: (@element) ->
    @recipe_groups   = @element.find(".recipe_group")
    @voting_buttons  = @element.find(".vote")
    @errors          = @element.find(".notice")
    @search_field    = @element.find("#search")
    @recipeRow       = @element.find(".recipes-row")

    @recipeRow.on     "ajax:success",  @voting_buttons,  @successfulVote
    @recipeRow.on     "ajax:error",    @voting_buttons,  @errorVote
    @search_field.on  "input",         @searchRecipes

  searchRecipes: =>
    query = @search_field.val()

    $.ajax
      url: "/search"
      data: { q: query }
      success: (console.log "hello")
      dataType: "script"

  successfulVote: (e, data, status, xhr) =>
    @count = $("#" + data.recipe)
    @vote  = $("#vote-" + data.recipe)

    if data.type == "create"
      @createVote(data)
    else
      @destroyVote(data)

  errorVote: =>
    @errors.html("Unfortunatly there was an error in your voting, please try again next time")
    @errors.show()

  createVote: (data) =>
    @count.text(parseInt(@count.text()) + 1)

    @vote.attr("href", "/votes/" + data.recipe + "/toggle?voted=true")
    @vote.addClass("btn-success")
    @vote.removeClass("btn-primary")
    @vote.html("Unvote")

  destroyVote: (data) =>
    @count.text(parseInt(@count.text()) - 1)

    @vote.attr("href", "/votes/" + data.recipe + "/toggle?voted=false")
    @vote.addClass("btn-primary")
    @vote.removeClass("btn-success")
    @vote.html("&nbsp;&nbsp; Vote &nbsp;&nbsp;")
$ ->
  new Pages($("body"))
