class Users
  constructor: (@element) ->
    @document       = $(document)
    @errors         = $(".notice")
    @job_field      = $("#add_job")
    @job_submit     = $("#job_submit")
    @job_container  = $(".job")
    @edit_job       = $("#edit_job")

    @job_submit.on "click", @submitJob

  submitJob: =>
    if @job_field.val() == ''
      @errors.html("Please enter text into the job field before submitting")
    else
      @sendRequest(@job_field.val())

  sendRequest: (job) =>
    $.ajax
      url: "/users/edit_job"
      data: { job: job }
      success: @successfulUpdate
      error: @errorUpdate
      dataType: "script"
      method: "POST"

  successfulUpdate: (e, data, status, xhr)  =>
    @job_container.html("<div class='center-text'>" + @job_field.val() + "</div>")

  errorUpdate: =>
    @errors.html("Unfortunatly there was an error while you updated your job, please try again next time")
    @errors.show()


$ ->
  new Users($("body"))
