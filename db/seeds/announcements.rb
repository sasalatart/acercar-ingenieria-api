require_relative './uploads'

def create_announcements!
  puts('Creating announcements...')

  %w[contact questions articles majors initial].map do |name|
    announcement = Announcement.new(pinned: true)
    add_uploaded_image(announcement, :picture, 'announcements', name)
    announcement.save!
  end
end
