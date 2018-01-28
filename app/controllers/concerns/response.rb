module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def paginated_json_response(object, status = :ok)
    paginate json: object, status: status
  end
end
