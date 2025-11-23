// Imports do Flutter
import 'package:flutter/material.dart';

/// Função principal que inicializa o aplicativo Flutter
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// Widget raiz do aplicativo
/// Configura o tema e a estrutura básica do MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRANCINALDO PARA O MUNDO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Página inicial do aplicativo
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FRANCINALDO PARA O MUNDO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20), // Verde escuro
          ),
        ),
        backgroundColor: Colors.green.shade50, // Verde muito claro
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner de Destaque
            _buildBannerSection(),
            
            // Campo de Pesquisa Rápida
            _buildSearchSection(context),
            
            // Seção de Título
            _buildTitleSection(context),
            
            // Seção de Botões (Navegação)
            _buildButtonSection(context),
            
            // Seção de Texto (Sobre a Agência)
            _buildTextSection(),
            
            // Seção de Destinos Populares
            _buildDestinationsSection(context),
          ],
        ),
      ),
    );
  }

  /// Banner de Destaque com imagem
  Widget _buildBannerSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flight_takeoff,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              'Explore o Mundo com a Gente!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'As melhores viagens estão aqui',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Campo de Pesquisa Rápida
  Widget _buildSearchSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: '🔎 Pesquisar destinos ou pacotes...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        onSubmitted: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Buscando por: $value'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  /// Passo 5: Construindo a Coluna da Seção Título
  Widget _buildTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'FRANCINALDO PARA O MUNDO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'Agência de Viagens',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
            size: 32,
          ),
          const SizedBox(width: 8),
          const Text(
            '4.8',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Passo 6: Construindo a Seção de Botões
  Widget _buildButtonSection(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.location_on, 'DESTINOS'),
        _buildButtonColumn(color, Icons.card_travel, 'PACOTES'),
        _buildButtonColumn(color, Icons.phone, 'CONTATO'),
        _buildButtonColumn(color, Icons.info, 'SOBRE'),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: buttonSection,
    );
  }

  /// Método auxiliar para criar colunas de botões
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 32),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  /// Passo 7: Definindo a Seção de Texto
  Widget _buildTextSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'A FRANCINALDO PARA O MUNDO é uma agência de viagens especializada em proporcionar experiências únicas e inesquecíveis. Oferecemos pacotes personalizados para os mais diversos destinos ao redor do globo. Nossa equipe experiente está pronta para ajudar você a planejar a viagem dos seus sonhos, com atenção especial a cada detalhe. Explore novos horizontes, descubra culturas diferentes e crie memórias que durarão para sempre. Viaje conosco e transforme seus sonhos em realidade!',
        softWrap: true,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  /// Seção de Destinos Populares com avaliações
  Widget _buildDestinationsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Destinos Populares',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildDestinationCard(
                  context,
                  'Buenos Aires, Argentina',
                  'Capital da Argentina',
                  4.9,
                  Icons.location_city,
                  Colors.blue,
                  'images/argentina.jpg',
                ),
                _buildDestinationCard(
                  context,
                  'Amazônia',
                  'Aldeia dos Povos Arrarra',
                  4.8,
                  Icons.forest,
                  Colors.green,
                  'images/povo.jpg',
                ),
                _buildDestinationCard(
                  context,
                  'João Pessoa, Paraíba',
                  'Capital da Paraíba',
                  4.7,
                  Icons.beach_access,
                  Colors.orange,
                  'images/joao pessoa.jpeg',
                ),
                _buildDestinationCard(
                  context,
                  'C.E.U Xamânico',
                  'Jacumã',
                  5.0,
                  Icons.spa,
                  Colors.purple,
                  'images/ceu.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Card de destino com avaliação de estrelas
  Widget _buildDestinationCard(
    BuildContext context,
    String title,
    String subtitle,
    double rating,
    IconData icon,
    Color color,
    String imageUrl,
  ) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinationDetailPage(
                  title: title,
                  subtitle: subtitle,
                  rating: rating,
                  icon: icon,
                  color: color,
                  imageUrl: imageUrl,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: color.withOpacity(0.2),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                size: 64,
                                color: color,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Adicione a imagem',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Página de detalhes do destino
class DestinationDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final IconData icon;
  final Color color;
  final String imageUrl;

  const DestinationDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.icon,
    required this.color,
    required this.imageUrl,
  });

  String _getDestinationInfo() {
    switch (title) {
      case 'Buenos Aires, Argentina':
        return '''Buenos Aires é a capital e maior cidade da Argentina, conhecida como a "Paris da América do Sul". 

📍 Localização: Localizada na margem ocidental do Rio da Prata, na costa sudeste do continente.

🏛️ Principais Atrações:
• Casa Rosada - sede do governo argentino
• Teatro Colón - um dos teatros de ópera mais importantes do mundo
• Caminito em La Boca - bairro colorido e vibrante
• Recoleta - famoso cemitério e bairro elegante
• Avenida 9 de Julio - uma das avenidas mais largas do mundo
• Tango - dança tradicional argentina

🍷 Cultura e Gastronomia:
• Carne argentina de alta qualidade
• Vinhos Malbec
• Cultura do tango e milongas
• Arquitetura europeia preservada

🌡️ Clima: Temperado, com verões quentes e invernos amenos.

✈️ Melhor época: Março a maio e setembro a novembro.''';

      case 'Amazônia':
        return '''A Amazônia é a maior floresta tropical do mundo, abrigando uma biodiversidade incomparável e comunidades indígenas tradicionais.

📍 Localização: Região norte do Brasil, abrangendo vários estados incluindo Amazonas, Pará, Acre, Rondônia, entre outros.

🌳 Características:
• Maior floresta tropical do planeta
• Abriga 10% de todas as espécies conhecidas
• Rio Amazonas - maior rio do mundo em volume de água
• Mais de 400 bilhões de árvores de 16.000 espécies diferentes

👥 Povos Indígenas:
• Aldeia dos Povos Arrarra - comunidade indígena tradicional
• Preservação de culturas ancestrais
• Conhecimento tradicional sobre plantas medicinais
• Artesanato indígena único

🦜 Biodiversidade:
• Mais de 2.500 espécies de peixes
• Centenas de espécies de mamíferos
• Milhares de espécies de aves
• Insetos e plantas ainda não catalogados

🌿 Experiências:
• Passeios de barco pelos rios
• Observação de animais silvestres
• Caminhadas na floresta
• Vivência com comunidades indígenas
• Banhos em igarapés e cachoeiras

⚠️ Importante: Respeitar o meio ambiente e as comunidades locais.''';

      case 'João Pessoa, Paraíba':
        return '''João Pessoa é a capital da Paraíba, conhecida como "Porta do Sol" por ser o ponto mais oriental das Américas.

📍 Localização: Litoral nordeste do Brasil, estado da Paraíba.

🏖️ Praias e Natureza:
• Praia de Tambaú - uma das mais famosas
• Praia do Seixas - ponto mais oriental das Américas
• Praia de Cabo Branco - com farol histórico
• Piscinas naturais em Picãozinho
• Areia branca e águas cristalinas

🏛️ Patrimônio Histórico:
• Centro Histórico bem preservado
• Igreja de São Francisco - barroco brasileiro
• Mosteiro de São Bento
• Casario colonial português

🌴 Pontos Turísticos:
• Estação Ciência, Cultura e Artes
• Parque Solon de Lucena (Lagoa)
• Jardim Botânico
• Farol do Cabo Branco

🍴 Gastronomia:
• Culinária nordestina autêntica
• Frutos do mar frescos
• Tapioca e cuscuz
• Cachaça artesanal

☀️ Clima: Tropical, com sol o ano todo.

🌅 Destaque: O nascer do sol mais cedo do Brasil!''';

      case 'C.E.U Xamânico':
        return '''O C.E.U Xamânico em Jacumã é um espaço místico e espiritual único, oferecendo experiências transformadoras.

📍 Localização: Jacumã, Paraíba, Brasil - um local sagrado e especial.

🧘 Experiências Espirituais:
• Cerimônias xamânicas tradicionais
• Conexão com a natureza e elementos
• Práticas de meditação e cura
• Vivências transformadoras

🌿 Ambiente Natural:
• Localização privilegiada em meio à natureza
• Energia especial do local
• Conexão com elementos da terra
• Paz e tranquilidade

✨ Atividades:
• Cerimônias de cura
• Meditações guiadas
• Práticas xamânicas
• Conexão espiritual
• Renovação energética

🎯 Para Quem:
• Buscadores de autoconhecimento
• Interessados em espiritualidade
• Pessoas em busca de transformação
• Amantes de práticas holísticas

💫 Diferencial:
• Experiência única e autêntica
• Ambiente sagrado e respeitoso
• Facilitadores experientes
• Transformação pessoal profunda

🌟 Avaliação: 5.0 estrelas - Experiência excepcional e transformadora!''';

      default:
        return 'Informações sobre este destino em breve.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner do destino com imagem real
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.3), color],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: 80, color: Colors.white),
                              const SizedBox(height: 16),
                              const Text(
                                'Adicione a imagem',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Overlay escuro para melhorar legibilidade do texto
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Conteúdo sobre a imagem
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                index < rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Informações do destino
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sobre o Destino',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getDestinationInfo(),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Funcionalidade de reserva em desenvolvimento'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.card_travel),
                      label: const Text('Reservar Agora'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
