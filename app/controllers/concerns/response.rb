module Response
  def json_response(object, status = :ok, serializer = nil)
    options = { json: object, status: status }
    options[:serializer] = serializer if serializer

    render options
  end

  def paginated_json_response(object, status = :ok)
    paginate json: object, status: status
  end
end
