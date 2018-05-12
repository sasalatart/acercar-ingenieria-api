require_relative './uploads'

@credits = [
  {
    resource_name: 'Environmental',
    resource_url: 'https://thenounproject.com/term/environmental/1091773/',
    author_name: 'Made',
    resource_meta: %w[major_logos environmental_made png]
  },
  {
    resource_name: 'Computer',
    resource_url: 'https://thenounproject.com/term/computer/1688783/',
    author_name: 'Susannanova',
    resource_meta: %w[major_logos computer_susannanova png]
  },
  {
    resource_name: 'Environment',
    resource_url: 'https://thenounproject.com/term/environment/1458371/',
    author_name: 'Becris',
    resource_meta: %w[major_logos environment_becris png]
  },
  {
    resource_name: 'Construction',
    resource_url: 'https://thenounproject.com/term/construction/141949/',
    author_name: 'Sergey Novosyolov',
    resource_meta: %w[major_logos construction_sergey_novosyolov png]
  },
  {
    resource_name: 'Construction Manager',
    resource_url: 'https://thenounproject.com/term/construction_manager/881227/',
    author_name: 'Gan Khoon Lay',
    resource_meta: %w[major_logos construction_manager_gan_khoon_lay png]
  },
  {
    resource_name: 'Transmission Tower',
    resource_url: 'https://thenounproject.com/term/transmission_tower/4747/',
    author_name: 'Olivier Guin',
    resource_meta: %w[major_logos transmission_tower_olivier_guin png]
  },
  {
    resource_name: 'Rock',
    resource_url: 'https://thenounproject.com/term/rock/5846/',
    author_name: 'Anuar Zhumaev',
    resource_meta: %w[major_logos rock_anuar_zhumaev png]
  },
  {
    resource_name: 'Waves',
    resource_url: 'https://thenounproject.com/term/waves/1352914/',
    author_name: 'Natasja Buer Toldam',
    resource_meta: %w[major_logos waves_natasja_buer_toldam png]
  },
  {
    resource_name: 'Gears',
    resource_url: 'https://thenounproject.com/term/gears/200525/',
    author_name: 'Alexander Skowalsky',
    resource_meta: %w[major_logos gears_alexander_skowalsky png]
  },
  {
    resource_name: 'Chemistry',
    resource_url: 'https://thenounproject.com/term/chemistry/465908/',
    author_name: 'Rockicon',
    resource_meta: %w[major_logos chemistry_rockicon png]
  },
  {
    resource_name: 'Analysis',
    resource_url: 'https://thenounproject.com/term/analysis/588602/',
    author_name: 'Artem Kovyazin',
    resource_meta: %w[major_logos analysis_artem_kovyazin png]
  },
  {
    resource_name: 'Pickaxe',
    resource_url: 'https://thenounproject.com/term/pickaxe/1404159/',
    author_name: 'Creaticca Creative Agency',
    resource_meta: %w[major_logos pickaxe_creaticca_creative_agency png]
  },
  {
    resource_name: 'Transport',
    resource_url: 'https://thenounproject.com/term/transport/1352224/',
    author_name: 'Made',
    resource_meta: %w[major_logos transport_made png]
  },
  {
    resource_name: 'Geode',
    resource_url: 'https://thenounproject.com/term/geode/18107/',
    author_name: 'Drue McCurdy',
    resource_meta: %w[major_logos geode_drue_mc_curdy png]
  },
  {
    resource_name: 'DNA',
    resource_url: 'https://thenounproject.com/term/dna/96527/',
    author_name: 'Lloyd Humphreys',
    resource_meta: %w[major_logos dna_lloyd_humphreys png]
  },
  {
    resource_name: 'X Ray',
    resource_url: 'https://thenounproject.com/term/x_ray/1066122/',
    author_name: 'H Alberto Gongora',
    resource_meta: %w[major_logos x_ray_h_alberto_gongora png]
  },
  {
    resource_name: 'Innovation',
    resource_url: 'https://thenounproject.com/term/innovation/447435/',
    author_name: 'Gregor Cresnar',
    resource_meta: %w[major_logos innovation_gregor_cresnar png]
  },
  {
    resource_name: 'Pi',
    resource_url: 'https://thenounproject.com/term/pi/607391/',
    author_name: 'Davo Sime',
    resource_meta: %w[major_logos pi_davo_sime png]
  },
  {
    resource_name: 'Architecture',
    resource_url: 'https://thenounproject.com/term/architecture/354603/',
    author_name: 'John T. Garcia',
    resource_meta: %w[major_logos architecture_john_t_garcia png]
  },
  {
    resource_name: 'Robot',
    resource_url: 'https://thenounproject.com/term/robot/960157/',
    author_name: 'Creaticca Creative Agency',
    resource_meta: %w[major_logos robot_creaticca_creative_agency png]
  },
  {
    resource_name: 'User',
    resource_url: 'https://thenounproject.com/term/user/1688840/',
    author_name: 'Alena Artemova',
    resource_meta: %w[client user_alena_artemova png]
  },
  {
    resource_name: 'School',
    resource_url: 'https://thenounproject.com/term/school/1276289/',
    author_name: 'AliWijaya',
    resource_meta: %w[client school_aliwijaya png]
  },
  {
    resource_name: 'Article',
    resource_url: 'https://thenounproject.com/term/article/1091930/',
    author_name: 'Creative Stall',
    resource_meta: %w[client article_creative_stall png]
  }
]

def create_credits!
  puts 'Creating credits...'
  @credits.each do |raw_data|
    credit = Credit.create!(raw_data.except(:resource_meta))
    add_uploaded_image(credit, :resource, *raw_data[:resource_meta])
  end
end
