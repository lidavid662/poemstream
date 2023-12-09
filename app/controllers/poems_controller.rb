class PoemsController < ApplicationController
  def index
    matching_poems = Poem.all

    @list_of_poems = matching_poems.order({ :created_at => :desc })

    render({ :template => "poems/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_poems = Poem.where({ :id => the_id })

    @the_poem = matching_poems.at(0)

    render({ :template => "poems/show" })
  end

  def create
    @current_user_id = current_user.id
    the_poem = Poem.new
    the_poem.title = params.fetch("query_title")
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI"))
    prompt = "Imageine you are a poet. Write a beautiful poem about "+params.fetch("query_poem")+" that is titled "+params.fetch("query_title")+". Respond with only the poem boyd itself."
    temp = Float(params.fetch("query_temp"))
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: prompt}],
        temperature: temp,
      }
    )
    the_poem.poem = response.dig("choices", 0, "message", "content")
    the_poem.user_id = @current_user_id

    if the_poem.valid?
      the_poem.save
      redirect_to("/poems", { :notice => "Poem created successfully." })
    else
      redirect_to("/poems", { :alert => the_poem.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_poem = Poem.where({ :id => the_id }).at(0)

    the_poem.title = params.fetch("query_title")
    the_poem.poem = params.fetch("query_poem")
    the_poem.user_id = params.fetch("query_user_id")

    if the_poem.valid?
      the_poem.save
      redirect_to("/poems/#{the_poem.id}", { :notice => "Poem updated successfully."} )
    else
      redirect_to("/poems/#{the_poem.id}", { :alert => the_poem.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_poem = Poem.where({ :id => the_id }).at(0)

    the_poem.destroy

    redirect_to("/poems", { :notice => "Poem deleted successfully."} )
  end
end
