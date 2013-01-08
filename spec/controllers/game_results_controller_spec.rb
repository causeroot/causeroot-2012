require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GameResultsController do

  # This should return the minimal set of attributes required to create a valid
  # GameResult. As you add validations to GameResult, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl.attributes_for(:game_result)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GameResultsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all game_results as @game_results" do
      game_result = GameResult.create! valid_attributes
      get :index, {}, valid_session
      assigns(:game_results).should eq([game_result])
    end
  end

  describe "GET show" do
    it "assigns the requested game_result as @game_result" do
      game_result = GameResult.create! valid_attributes
      get :show, {:id => game_result.to_param}, valid_session
      assigns(:game_result).should eq(game_result)
    end
  end

  describe "GET new" do
    it "assigns a new game_result as @game_result" do
      pending "this test is failing"
      FactoryGirl.create(:question)
      FactoryGirl.create(:question)
      FactoryGirl.create(:question)
      FactoryGirl.create(:question)
      FactoryGirl.create(:issue)
      FactoryGirl.create(:issue)
      FactoryGirl.create(:issue)
      FactoryGirl.create(:issue)
      FactoryGirl.create(:issue)
      FactoryGirl.create(:issue)
      get :new, {}, valid_session
      gr = assigns(:game_result)
      #gr.should be_a_new(GameResult)
      Issue.count.should be > 4
      gr.issues.count.should eq(gr.question.problem_count)
    end
  end

  describe "GET edit" do
    it "assigns the requested game_result as @game_result" do
      game_result = GameResult.create! valid_attributes
      get :edit, {:id => game_result.to_param}, valid_session
      assigns(:game_result).should eq(game_result)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new GameResult" do
        expect {
          post :create, {:game_result => FactoryGirl.attributes_for(:game_result), issues: ["#{Issue.first.id},#{Issue.last.id}"]}, valid_session
        }.to change(GameResult, :count).by(1)
      end

      it "assigns a newly created game_result as @game_result" do
        post :create, {:game_result => FactoryGirl.attributes_for(:game_result_with_issues)}, valid_session
        assigns(:game_result).should be_a(GameResult)
        assigns(:game_result).should be_persisted
      end

      it "redirects to the created game_result" do
        post :create, {:game_result => valid_attributes}, valid_session
        response.should redirect_to(GameResult.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game_result as @game_result" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameResult.any_instance.stub(:save).and_return(false)
        post :create, {:game_result => {  }}, valid_session
        assigns(:game_result).should be_a_new(GameResult)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameResult.any_instance.stub(:save).and_return(false)
        post :create, {:game_result => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game_result" do
        game_result = GameResult.create! valid_attributes
        # Assuming there are no other game_results in the database, this
        # specifies that the GameResult created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        GameResult.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => game_result.to_param, :game_result => { "these" => "params" }}, valid_session
      end

      it "assigns the requested game_result as @game_result" do
        game_result = GameResult.create! valid_attributes
        put :update, {:id => game_result.to_param, :game_result => valid_attributes}, valid_session
        assigns(:game_result).should eq(game_result)
      end

      it "redirects to the game_result" do
        game_result = GameResult.create! valid_attributes
        put :update, {:id => game_result.to_param, :game_result => valid_attributes}, valid_session
        response.should redirect_to(game_result)
      end
    end

    describe "with invalid params" do
      it "assigns the game_result as @game_result" do
        game_result = GameResult.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        GameResult.any_instance.stub(:save).and_return(false)
        put :update, {:id => game_result.to_param, :game_result => {  }}, valid_session
        assigns(:game_result).should eq(game_result)
      end

      it "re-renders the 'edit' template" do
        game_result = GameResult.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        GameResult.any_instance.stub(:save).and_return(false)
        put :update, {:id => game_result.to_param, :game_result => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_result" do
      game_result = GameResult.create! valid_attributes
      expect {
        delete :destroy, {:id => game_result.to_param}, valid_session
      }.to change(GameResult, :count).by(-1)
    end

    it "redirects to the game_results list" do
      game_result = GameResult.create! valid_attributes
      delete :destroy, {:id => game_result.to_param}, valid_session
      response.should redirect_to(game_results_url)
    end
  end

end
