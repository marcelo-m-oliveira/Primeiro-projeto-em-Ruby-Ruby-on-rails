module ApplicationHelper

    def locale
        I18n.locale == :en ? "US" : "pt-BR"
    end

    def date_br(date_us)
        date_us.strftime("%d/%m/%Y")
    end
    
    def environment_rails
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else
            "Teste"
        end
    end
end
