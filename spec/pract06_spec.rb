require "./lib/pract06"

describe Referencias do
	before :each do
    
		@ref1 = Referencias.new(['autor1','autor2'], 'titulo', 'editorial', 1, '24/07/1990', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491'], 'serie') 
		@ref2 = Referencias.new(['Dave Thomas','Andy Hunt', 'Chad Fowler'], 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide', 'Pragmatic Bookshelf', 4, '07/07/2013', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491'], 'The Facets of Ruby') 
		@ref3 = Referencias.new(['autor1','autor2'], 'titulo', 'editorial', 1, '24/07/1990', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491']) 
	end  
	
	describe "Almacenamiento de las referencias"  do
		it "Debe existir uno o mas autores y un metodo para acceder a ellos" do
			
			expect(@ref1.autor.length).to be > 1
			expect(@ref1.autor[0]).to eq('autor1') 
			expect(@ref1.autor[1]).to eq('autor2') 
		end
		
		it "Debe existir un titulo y un metodo para acceder a el" do
			expect(@ref1.titulo).to eq('titulo')		
		end
		
		it "Debe existir o no serie y un metodo para acceder a ella (si no existe se pondra como null)" do
			expect(@ref1.serie).to eq('serie')		
			expect(@ref3.serie).to eq('null')		
		end
		
		
		it "Debe existir un numero de edicion y un metodo para acceder a el" do
			expect(@ref1.numEdicion).to eq(1)
		end
		it "Debe existir una fecha de lanzamiento y un metodo para acceder a ella" do
			expect(@ref1.fechaDate).to be_an_instance_of(Date)
		end
		
		it "Debe existir una fechaDate de tipo fecha y un metodo para acceder a ella" do
			expect(@ref1.fecha).to eq('24/07/1990')
		end
		
		it "Debe existir uno o mas codigos ISBN y un metodo para acceder a ellos" do
			expect(@ref1.codISBN.length).to be > 1
			expect(@ref1.codISBN[0]).to eq('ISBN-13: 978-1937785499')
			expect(@ref1.codISBN[1]).to eq('ISBN-10: 1937785491')
		end
	end
        describe "Deben exsistir los siguientes metodos para visualizar el contenido"  do
                it  "Debe existir un metodo que imprima los autores" do

                        expect(@ref1.autorPrint()).to eq("autor1, autor2.")
		end
		it "Debe existir un metodo que imprima los codigos ISBN" do
			expect(@ref1.codISBNprint()).to eq("ISBN-13: 978-1937785499\nISBN-10: 1937785491")

		end
		it "Debe existir un metodo que imprima la fecha formateada" do
			expect(@ref1.fechaFormateada()).to eq("July 24, 1990")
		end
		it "Debe existir un metodo para obtener la referencia completa formateada con o sin serie" do
			expect(@ref1.salidaFormateada()).to eq("autor1, autor2.\ntitulo\n(serie)\neditorial; 1 edition (July 24, 1990)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
			expect(@ref2.salidaFormateada()).to eq("Dave Thomas, Andy Hunt, Chad Fowler.\nProgramming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide\n(The Facets of Ruby)\nPragmatic Bookshelf; 4 edition (July 7, 2013)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
			expect(@ref3.salidaFormateada()).to eq("autor1, autor2.\ntitulo\neditorial; 1 edition (July 24, 1990)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
		end
	end
end
