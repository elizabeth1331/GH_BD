begin
as_pdf_mini.init;
--p_format formato de la hoja, p_orientation direccion de la hoja PORTRAIT o LANDSCAPE
AS_PDF_MINI.SET_FORMAT(p_format=>'A4',p_orientation=>'PORTRAIT');
as_pdf_mini.write( 'La versión mini de AS_PDF se limita a los 14 PDF- fuentes estándar y la codificación WINDOWS- 1252.' );
as_pdf_mini.set_font( 'helvetica' );
as_pdf_mini.write( 'helvetica, normal: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, 700 );
as_pdf_mini.set_font( 'helvetica', 'I' );
as_pdf_mini.write( 'helvetica, italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'helvetica', 'b' );
as_pdf_mini.write( 'helvetica, bold: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'helvetica', 'BI' );
as_pdf_mini.write( 'helvetica, bold italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'times' );
as_pdf_mini.write( 'times, normal: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, 625 );
as_pdf_mini.set_font( 'times', 'I' );
as_pdf_mini.write( 'times, italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'times', 'b' );
as_pdf_mini.write( 'times, bold: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'times', 'BI' );
as_pdf_mini.write( 'times, bold italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'courier' );
as_pdf_mini.write( 'courier, normal: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, 550 );
as_pdf_mini.set_font( 'courier', 'I' );
as_pdf_mini.write( 'courier, italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'courier', 'b' );
as_pdf_mini.write( 'courier, bold: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'courier', 'BI' );
as_pdf_mini.write( 'courier, bold italic: ' || 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
--
as_pdf_mini.set_font( 'courier' );
as_pdf_mini.write( 'symbol:', -1, 475 );
as_pdf_mini.set_font( 'symbol' );
as_pdf_mini.write( 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
as_pdf_mini.set_font( 'courier' );
as_pdf_mini.write( 'zapfdingbats:', -1, -1 );
as_pdf_mini.set_font( 'zapfdingbats' );
as_pdf_mini.write( 'Guayaquil es la perla del pacifico. 1234567890', -1, -1 );
--
as_pdf_mini.set_font( 'times', 'N', 20 );
as_pdf_mini.write( 'times, normal with fontsize 20pt', -1, 400 );
as_pdf_mini.set_font( 'times', 'N', 6 );
as_pdf_mini.write( 'times, normal with fontsize 5pt', -1, -1 );
--P_DIR es el directorio donde se almacenara los archivos,P_FILENAME es el nombre del archivo que se va a generar
as_pdf_mini.save_pdf(p_dir=>'PDF',p_filename=>'EjemploPDF_3.pdf');
end;