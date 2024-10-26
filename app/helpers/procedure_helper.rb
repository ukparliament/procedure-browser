module ProcedureHelper

  def procedure_dates( procedure )
    procedure_dates = ''
    procedure_dates += procedure.start_on.strftime( $DATE_DISPLAY_FORMAT ) if procedure.start_on
    procedure_dates += ' - ' if procedure.start_on
    procedure_dates += procedure.end_on.strftime( $DATE_DISPLAY_FORMAT ) if procedure.end_on
    procedure_dates
  end
end
