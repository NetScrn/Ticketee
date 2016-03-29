class CommentNotifier < ApplicationMailer
  def create(comment, user)
    @comment = comment
    @user = user
    @ticket = comment.ticket
    @project = @ticket.project

    subject = "[ticketee] #{@project.name} - #{@ticket.name}"
    mail(to: user.email, subject: subject)
  end
end
