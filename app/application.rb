class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)


    if req.path.match(/items/)
      search_term = req.path
      if find_item(search_term)
        new_item = find_item(search_term)
        resp.write new_item.name
        resp.write new_item.price
        resp.status = 200
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def find_item(search_term)
    item_name = search_term.split('/items/').last
    new_item = @@items.find do |item|
      item.name == item_name
    end
    if new_item
      #resp.status = 200
      return new_item
    else
      #resp.status = 400
      return nil
    end
  end

end
