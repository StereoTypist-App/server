class TextsController < ApplicationController
    def new
        @text = Text.new
        return redirect_to "/" if !current_user
    end

    def create
        return redirect_to "/" if !current_user
        if current_user && current_user.results.count > 0 && current_user.results.order(wpm: :desc).limit(1)[0].wpm >= 50 then
            @text = Text.new
            @text.title = params[:text][:title]
            @text.text = params[:text][:text]
            @text.user = current_user
            if @text.save then
                flash[:title]="Success"
                flash[:notice]="Text saved"
                redirect_to '/'
            else
                flash[:title]="Error"
                flash[:notice]=@text.errors.to_a.to_sentence
                render 'new'
            end
        else
            redirect_to "/"
        end
    end
end
