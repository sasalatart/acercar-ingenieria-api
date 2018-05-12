require_relative './uploads'

def create_announcements!
  puts('Creating announcements...')

  %w[initial majors articles questions contact].map do |name|
    announcement = Announcement.create!(pinned: true)
    add_uploaded_image(announcement, :picture, 'announcements', name)
  end
end
