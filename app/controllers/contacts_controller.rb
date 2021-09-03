class ContactsController < ApplicationController
  load_and_authorize_resource
  before_action :find_candidate, only: %i[new create]

  def index
    @contacts = current_user.contacts.order('created_at DESC').page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new(session[:contact_us_params])
  end

  def create
    recaptcha_passed = verify_recaptcha(model: @contact)
    @contact = @user.contacts.build(contact_params)
    if recaptcha_passed && @contact.save
      session.delete(:contact_us_params)
      flash[:success] = t('flash.contacts.success', user_name: @user.first_name)
    else
      session[:contact_us_params] = contact_params
      flash[:error] = t('flash.contacts.recaptcha') unless recaptcha_passed
      flash[:error] = @contact.errors.full_messages.join(', ') if recaptcha_passed
    end
    redirect_to cv_section_path(@user.subdomain)
  end

  private

  def find_candidate
    @user = User.find_by(id: contact_params[:user_id])
  end

  def contact_params
    params.require(:contact).permit!
  end
end
