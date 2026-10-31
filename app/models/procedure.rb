class Procedure
  
  attr_accessor :identifier
  attr_accessor :label
  attr_accessor :description
  attr_accessor :display_order
  attr_accessor :start_on
  attr_accessor :end_on
  attr_accessor :step_display_depth_value
  attr_accessor :calculation_style_identifer
  attr_accessor :calculation_style_label
  
  def id
    self.identifier.split( '/' ).last
  end
  
  def calculation_style_id
    self.calculation_style_identifer.split( '/' ).last
  end
  
  # ## A method returning the URL of hand-drawn map of the procedure.
  # TODO: this is a short-term hack. We need to move this information back to the data model.
  def map_url
    
    # We create a hash mapping procedure IDs to map urls.
    map_urls = {
      'D00dsjR2' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/crag-treaties',
      'H5YJQsK2' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/draft/draft-affirmative',
      'iWugpxMn' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/made/made-affirmative',
      'gTgidljI' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/draft/draft-negative',
      '5S6p4YsP' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/made/made-negative',
      'iCdMN1MW' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/proposed-negative-sis/proposed-negative-sis',
      'kgFvgMIf' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/legislative-reform-order',
      'OvnVdtXG' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/proposed-draft-remedial-order/proposed-draft-remedial-order',
      '1HAWKzS2' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/draft-affirmative/draft-affirmative',
      'iAISgq1R' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/made-affirmative/made-affirmative',
      'dWV8Yjj6' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/enhanced-affirmative-under-ipa16/enhanced-affirmative-under-IPA16',
      'jaKY87jt' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/published-drafts-under-euwa/published-drafts-under-euwa',
      'pWKSg0gl' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/public-bills',
      'BVXfjPCq' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/prerogative-consent/queens-consent/queens-consent',
      'wu1umwQp' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/prerogative-consent/prince-of-wales-consent/prince-of-wales-consent',
      'N0wGCkVi' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/prerogative-consent/great-steward-of-scotlands-consent/great-steward-of-scotlands-consent',
      'TKoIB3wb' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/commons/first-reading/first-reading',
      'Ir0uTlIX' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/commons/ten-minute-rule/ten-minute-rule',
      '6J4vIkHl' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/devolved-legislature-consent/scottish-parliament/scottish-parliament-consent',
      '9f4uTpRT' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/devolved-legislature-consent/northern-ireland-assembly/northern-ireland-assembly-consent',
      'Z0zMk6F7' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/primary/public-bills/components/devolved-legislature-consent/senedd-cymru/senedd-cymru-consent',
      '6Ko0lqag' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/components/evel-certification/evel-certification',
      'to26jAxE' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/components/local-government-finance-report/local-government-finance-report',
      'y2jlrQHV' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/components/jcsi/jcsi',
      'Rs3ZCwcM' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/components/scsi/scsi',
      '8M2uUbfD' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/components/slsc/slsc',
      'a88v87y7' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/lords/lords-committees/lords-committees',
      'EOdm38mm' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/niac',
      'GMnnFGmR' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/bat/btc',
      'q42AXb3t' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/jchr/jchr',
      'r66QlB5Y' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/lords/iac+eac/iac+eac',
      'BrFonVHh' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/pac/pac',
      'TKmBNPtQ' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/other-commons-committees/other-commons-committees',
      'R8oDwdeY' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/pre-laying-scrutiny/pre-laying-scrutiny',
      'Xi2z3U8E' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/itc/itc',
      'PAREo4vo' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/efra/efra',
      'ukQX5dUZ' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/hac/hac',
      'DB2Pud1m' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/draft/components/jcsi-scrutiny-reserve/jcsi-scrutiny-reserve-draft-affirmative',
      '0g8JqRKX' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/draft-negative/draft-negative',
      'CisA7G2J' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/made-affirmative/components/jchr-scrutiny-reserve/jchr-scrutiny-reserve',
      'XwRdXhdV' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/draft-affirmative/draft-affirmative',
      'HHtm6lV2' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/remedial-orders/made-affirmative/components/jchr-scrutiny-reserve/jchr-scrutiny-reserve',
      'meSrUdup' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/lords/procedure-determination/procedure-determination',
      'TDAfUhJs' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/commons/procedure-determination/procedure-determination',
      'Gcmptq78' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/lords/committee-consideration/committee-consideration',
      'h8um2RcQ' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/commons/committee-consideration/committee-consideration',
      'QphyqYDL' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/lords/debates/debates',
      '6cXS1d0v' => 'https://ukparliament.github.io/ontologies/procedure/procedure/maps/legislation/secondary/statutory-instruments/super-affirmative-procedures/legislative-reform-orders/components/lords/dprrc-scrutiny-reserve/dprrc-scrutiny-reserve',
      'Cejma7zC' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/made/components/motions/commons-motions/commons-motions-made-affirmative',
      'ecbeGCZ9' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/draft/components/motions/commons-motions/commons-motions-draft-affirmative',
      'oMkNXay7' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/draft/components/motions/lords-motions/lords-motions-draft-affirmative',
      'hrJYrGBa' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/draft/components/motions/commons-motions/commons-motions',
      'ry9EEfnt' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/affirmative-procedures/made/components/motions/lords-motions/lords-motions-made-affirmative',
      '0lTeVj1H' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/made/components/referral-to-delegated-legislation-committee/delegated-legislation-referral',
      'g5pzLJuJ' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/made/components/motions/commons-motions/commons-motions',
      'n1cwCAM5' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/draft/components/referral-to-delegated-legislation-committee/draft%20negative-delegated-legislation-committee-referral',
      'TT4LlWHi' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/made/components/motions/commons-motions/motions-to-consider/commons-motion-to-consider',
      '8NxeCe90' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/made/components/motions/lords-motions/lords-motions-made-negative',
      'bcHA3ujX' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/draft/components/motions/commons-motions/motions-to-consider/commons-motion-to-consider',
      'XbKACVVg' => '', # Localism order. Not mapped?
      '0cW7qCcg' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/statutory-instruments/negative-procedures/draft/components/motions/lords-motions/lords-motions-draft-negative',
      'mxxnneEz' => 'https://ukparliament.github.io/ontologies/procedure/maps/legislation/secondary/proposed-negative-sis/commons-committees/commons-committees',
      'bsh0OXka' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/commons/motions/commons-motions',
      'bERQxiVp' => 'https://ukparliament.github.io/ontologies/procedure/maps/treaties/crag-treaties/components/lords/motions/lords-motions',
    }
  
  
    # CRaG Treaties - Lords motions
  
    # We pull the URL of the map from this procedure from the hash.
    map_urls[ self.id ]
  end
  
  def map_url_svg
    self.map_url + '.svg'
  end
  
  def map_url_pdf
    self.map_url + '.pdf'
  end
end
