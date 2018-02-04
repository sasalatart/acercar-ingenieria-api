require_relative './uploads'

def create_announcements!
  puts('Creating announcements...')

  %w[initial majors articles questions contact].map do |name|
    Announcement.create!(picture: create_uploaded_image('announcements', name),
                         pinned: true)
  end
end
