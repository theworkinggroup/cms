module CmsHelper
  
  CMS_C = %w( crazy cool colorful cremated creamed crusty clapping campy crude corky comfortable crappy cromulent childish crafty cruddy creaky cranky catatonic comatose circular curvaceous crabby cyan canned clobbered controlling candid cagey callous capable capricious ceaseless changeable cheerful chilly chivalrous chubby chunky clammy classy cloistered cloudy clumsy coherent cold colossal combative comfortable cooing cooperative courageous cowardly craven credible creepy crooked cuddly cultured curly curved cynical casual).freeze
  CMS_M = %w( massive monster mini mighty morbid mexican moses machine mucus murder macabre macho maddening madly magenta magical magnificent majestic makeshift malicious mammoth maniacal many marked massive materialistic mature measly meek melodic merciful mere mighty mindless miniature minor miscreant moaning modern moldy momentous muddled mundane murky mushy mysterious).freeze
  CMS_S = %w( scott sean sack sail salt sand scale scarecrow scarf scene scent school science scissors screw sea seashore seat secretary seed selection self sense servant shade shake shame shape sheep sheet shelf ship shirt shock shoe shoes shop show side sidewalk sign silk silver sink sister sisters size skate skin skirt sky slave sleep sleet slip slope smash smell smile smoke snail snails snake snakes sneeze snow soap society sock soda sofa son song songs sort sound soup space spade spark spiders sponge spoon spot spring spy square squirrel stage stamp star start statement station steam steel stem step stew stick sticks stitch stocking stomach stone stop store story stove stranger straw stream street stretch string structure substance sugar suggestion suit summer sun support surprise sweater swim swing system sangria).freeze
  
  def application_name
    ComfortableMexicanSofa::Config.cms_title || 
    [CMS_C, CMS_M, CMS_S].collect{|a| a.sort_by{rand}.first.capitalize}.join
  end

end