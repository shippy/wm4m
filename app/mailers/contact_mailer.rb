class ContactMailer < ActionMailer::Base
  default from: "no-reply@watchme4.me"
  def depressing_email(user, contact)
      mail(to: contact.email,
      	   body: "Dear" + contact.name + ", " + user.name + " has listed you as an emergency contact in the event of periods of low mental health. Please get in touch with " + user.name + " when you have a moment to talk.",
	    content_type: "text/plain",
	    subject: "Reaching out")
	end
end
