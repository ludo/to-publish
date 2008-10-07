xml.instruct!
xml.feed :xmlns => "http://www.w3.org/2005/Atom" do |feed|
  feed.title "Cubicphuse"
  feed.link "http://#{request.host}"
  feed.updated((@articles.any? ? @articles.first.published_at : DateTime.now).strftime("%Y-%m-%dT%H:%M:%SZ"))
  feed.author do |author|
    author.name "Ludo van den Boom"
  end
  feed.id "http://#{request.host}"

  for article in @articles
    feed.entry do |entry|
      url = "http://#{request.host}" << path_to_content(article)
      
      entry.title(article)
      entry.published(article.published_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.updated(article.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.link(:href => url)
      entry.id(url)
      
      if article.summary?
        entry.summary(:type => "html") do |summary|
          summary.text!(article.summary)
        end
      else
        entry.content(:type => "html") do |content|
          content.text!(prepare(article))
        end
      end
    end
  end
end