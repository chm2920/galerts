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
    header_part, body_part = mail.lstrip.split(/#{CRLF}#{CRLF}|#{CRLF}#{WSP}*#{CRLF}(?!#{WSP})/m, 2)
    
    parts = mail.split('Content-Type: text/html')
    if parts.length > 2
      content = parts[1]
      hsh = {}
      
      blocks = content.split('ebeff9')
      0.upto (blocks.length - 1) do |i|
        block = blocks[i]
        block_t = ''
        block_c = []
        
        block.scan(/<u><\/u><b>(.*?)<\/b><u><\/u>/m) do |t|
          block_t = t[0].to_s
        end        
        
        block.scan(/<td style(.*?)<\/td>/m) do |t|
          hsh_block_c = {}
          msg = t[0].to_s
          hsh_block_c["msg"] = msg
          msg.scan(/1111cc" href="(.*?)"(.*?)>(.*?)<\/a>/) do |link, b, title|
            puts title
            hsh_block_c["link"] = link[0].to_s
            hsh_block_c["title"] = title[0].to_s
          end
          
          msg.scan(/777777">(.*?)</) do |source|
            hsh_block_c["source"] = source[0].to_s
          end
          
          hsh_block_c["summary"] = msg.split('<br>')[2]
          
          block_c << hsh_block_c
        end
        
        hsh[block_t] = block_c
      end
      arr = []
      hsh.each do |k, v|
        arr << "<b>" + k + "</b><br />"
        v.each do |b|
          arr << "msg--" + b["msg"].gsub('<', '&lt;').gsub('>', '&gt;') + "<br />" if b["msg"]
          arr << "title--" + b["title"] + "<br />" if b["title"]
          arr << "link--" + b["link"] + "<br />" if b["link"]
          arr << "source--" + b["source"] + "<br />" if b["source"]
          arr << "summary--" + b["summary"] + "<br />" if b["summary"]
          arr << "<br />"
        end
      end
      arr.join('').html_safe
      #hsh.to_json
    else
      
      # require 'mail'
      # puts 'a'
      # obj_mail = Mail.new(mail.to_s)
      # puts 'b'
      # # RubyVer.decode_base64(body_part)
      # # body_part.unpack( 'm' ).first.force_encoding('ASCII_8BIT')
      # obj_mail.methods.sort.join("<br />").html_safe
      mail
    end
  end
  
end
