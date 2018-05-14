require_relative './uploads'

def create_announcements!
  puts('Creating announcements...')

  %w[initial majors articles questions contact].map do |name|
    announcement = Announcement.new(pinned: true)
    add_uploaded_image(announcement, :picture, 'announcements', name)
    announcement.save!
  end
end
