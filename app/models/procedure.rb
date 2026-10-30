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
      '' => '',
      '' => '',
      '' => '',
      '' => '',
      '' => '',
    }
  
    
    
    
    
    
    
    #BVXfjPCq Queen's consent
    #wu1umwQp Prince of Wales's consent
    #N0wGCkVi Great Steward of Scotland's consent
    #TKoIB3wb Commons first reading
    #Ir0uTlIX Commons ten minute rule bill
    #6J4vIkHl Legislative Consent Motion - Scottish Parliament
    #9f4uTpRT Legislative Consent Motion - Northern Ireland Assembly
    #Z0zMk6F7 Legislative Consent Motion - Senedd Cymru
    #6Ko0lqag English votes for English laws (EVEL)
    #to26jAxE Local Government Finance Report
    #y2jlrQHV Joint Committee on Statutory Instruments (JCSI)
    #Rs3ZCwcM Select Committee on Statutory Instruments (SCSI)
    #8M2uUbfD Secondary Legislation Scrutiny Committee (SLSC)
    #a88v87y7 CRAG Treaty Lords Committee
    #EOdm38mm CRAG Treaty NIAC
    #GMnnFGmR CRAG Treaty Business and Trade Committee
    #q42AXb3t CRAG Treaty JCHR
    #r66QlB5Y CRAG Treaty IAC+EAC
    #BrFonVHh CRAG Treaty PAC
    #TKmBNPtQ CRAG Treaty other commons committees
    #R8oDwdeY CRaG Treaty pre-laying scrutiny
    #Xi2z3U8E CRAG Treaty ITC
    #PAREo4vo CRAG Treaty EFRA
    #ukQX5dUZ CRAG Treaty HAC
    #DB2Pud1m Draft affirmative: Joint Committee on Statutory Instruments (JCSI) Scrutiny Reserve
    #0g8JqRKX Legislative reform order: Draft negative
    #CisA7G2J Scrutiny Reserve - Joint Committee on Human Rights (JCHR)
    #XwRdXhdV Legislative reform order: Draft affirmative
    #HHtm6lV2 Made affirmative: Joint Committee on Statutory Instruments (JCSI) Scrutiny Reserve
    #meSrUdup Legislative reform order: Lords procedure determination
    #TDAfUhJs Legislative reform order: Commons procedure determination
    #Gcmptq78 Legislative reform order: Lords committee consideration
    #h8um2RcQ Legislative reform order: Commons committee consideration
    #QphyqYDL Legislative reform order: Lords debates
    #6cXS1d0v DPRRC scrutiny reserve
    #Cejma7zC Made affirmative: Commons motions
    #ecbeGCZ9 Draft affirmative: Commons motions
    #oMkNXay7 Draft affirmative: Lords motions
    #hrJYrGBa Draft negative: Commons motions
    #ry9EEfnt Made affirmative: Lords motions
    #0lTeVj1H Made negative: Referral to a Delegated Legislation Committee (DLC)
    #g5pzLJuJ Made negative: Commons motions
    #n1cwCAM5 Draft negative: Referral to a Delegated Legislation Committee (DLC)
    #TT4LlWHi Made negative - Commons motion to consider
    #8NxeCe90 Made negative: Lords motions
    #bcHA3ujX Draft negative - Commons motion to consider
    #XbKACVVg Localism order
    #0cW7qCcg Draft negative: Lords motions
    #mxxnneEz Proposed negative statutory instruments: Commons committees
    #bsh0OXka CRaG Treaties - Commons motions
    #bERQxiVp CRaG Treaties - Lords motions
  
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
