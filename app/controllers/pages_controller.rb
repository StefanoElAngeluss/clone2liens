class PagesController < ApplicationController
    def accueil; end

    # def download
    #     pdf = Prawn::Document.new
    #     pdf.text 'Hello world'
    #     send_data(pdf.render,
    #         filename: 'hello_world.pdf',
    #         type: 'application/pdf')
    # end

    # def preview
    #     pdf = Prawn::Document.new
    #     pdf.text 'This is a preview'
    #     pdf.text 'It only shows up in the preview route'
    #     pdf.start_new_page
    #     pdf.text 'This is a new page'
    #     send_data(
    #         pdf.render,
    #         filename: 'export.pdf',
    #         type: 'application/pdf',
    #         disposition: 'inline')
    # end

    def contact
    end

    def about
    end

    def privacy
    end
end
