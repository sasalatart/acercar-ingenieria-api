module Response
  def json_response(object, options = {})
    options[:status] ||= :ok
    options[:json] = object

    render options
  end

  def paginated_json_response(object, options = {})
    options[:status] ||= :ok
    options[:json] = object

    paginate options
  end
end
