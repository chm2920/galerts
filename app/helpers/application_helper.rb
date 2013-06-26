module ApplicationHelper
  
  white_space = %Q|\x9\x20|
  text        = %Q|\x1-\x8\xB\xC\xE-\x7f|
  field_name  = %Q|\x21-\x39\x3b-\x7e|
  qp_safe     = %Q|\x20-\x3c\x3e-\x7e|
  
  aspecial     = %Q|()<>[]:;@\\,."| # RFC5322
  tspecial     = %Q|()<>@,;:\\"/[]?=| # RFC2045
  sp           = %Q| |
  control      = %Q|\x00-\x1f\x7f-\xff|
  
  if control.respond_to?(:force_encoding)
    control = control.force_encoding(Encoding::BINARY)
  end
  
  CRLF          = /\r\n/
  WSP           = /[#{white_space}]/
  FWS           = /#{CRLF}#{WSP}*/
  TEXT          = /[#{text}]/ # + obs-text
  FIELD_NAME    = /[#{field_name}]+/
  FIELD_BODY    = /.+/
  FIELD_LINE    = /^[#{field_name}]+:\s*.+$/
  FIELD_SPLIT   = /^(#{FIELD_NAME})\s*:\s*(#{FIELD_BODY})?$/
  HEADER_LINE   = /^([#{field_name}]+:\s*.+)$/

  QP_UNSAFE     = /[^#{qp_safe}]/
  QP_SAFE       = /[#{qp_safe}]/
  CONTROL_CHAR  = /[#{control}]/n
  ATOM_UNSAFE   = /[#{Regexp.quote aspecial}#{control}#{sp}]/n
  PHRASE_UNSAFE = /[#{Regexp.quote aspecial}#{control}]/n
  TOKEN_UNSAFE  = /[#{Regexp.quote tspecial}#{control}#{sp}]/n
  
  def mail_info(mail)    
    require "base64"
    
    header_part, body_part = mail.lstrip.split(/#{CRLF}#{CRLF}|#{CRLF}#{WSP}*#{CRLF}(?!#{WSP})/m, 2)
    
    boundary = ""
    mail.scan(/boundary=(.*?) --/) do |b|
      boundary = b[0].to_s
    end
    
    content = body_part.split('--' + boundary)[1]
    content = content.split('base64')[1]
    content = Base64.decode64(content)
    content = content.split('This once a day')[0]
         
    info = {}
    info["result"] = {}
    content.scan(/new results for \[(.*?)\]/) do |a|
      info["alert"] = a[0].to_s
    end
    
    arr = content.split(/\n==/)
    
    0.upto (arr.length - 1) do |i|
      section_t = ''
      as = []
      arr[i].scan(/= (.*?) -/) do |t|
        section_t = t[0].to_s
      end
    
      bs = arr[i].split("\r\n\r\n")
    
      1.upto (bs.length - 1) do |j|
        obj = {}
        bs[j].scan(/(.*?)\r\n(.*?)\r\n(.*?)\r\n<(.*?)>/m) do |a, b, c, d|
          obj["title"] = a
          if b.length > 40
            obj["summary"] = b + "\r\n" + c
          else
            obj["source"] = b
            obj["summary"] = c
          end
          obj["summary"] = obj["summary"].gsub("\r\n", " ")
          obj["link"] = d.to_s
          d.scan(/url\?sa=X&q=(.*?)&ct=ga/) do |link|
            obj["link"] = link[0].to_s
          end
        end
        as.push(obj)
      end
      info["result"][section_t] = as
    end
    
    info.to_json
  end
  
end
