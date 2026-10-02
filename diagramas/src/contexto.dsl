workspace "ScalperObliterator3000" "Contexto da venda de ingressos para um evento de alta demanda" {

    model {
        comprador = person "Comprador legítimo" "Compra ingressos para si e acompanhantes."

        revendedor = person "Revendedor" "Coordena contas para obter ingressos acima da cota." {
            tags "Adversário"
        }

        administrador = person "Administrador da plataforma" "Configura e revisa os controles de compra."

        plataforma = softwareSystem "ScalperObliterator3000" "Vende ingressos para diferentes eventos e limita a compra no evento analisado a quatro ingressos por conta." {
            tags "Sistema em análise"
        }

        identidade = softwareSystem "Serviço de verificação de identidade" "Confirma uma identidade quando esse controle eventual é ativado." {
            tags "Integração eventual"
        }

        pagamento = softwareSystem "Serviço de pagamento" "Fornece a confirmação externa necessária para concluir a compra." {
            tags "Sistema externo"
        }

        comprador -> plataforma "Consulta a disponibilidade e solicita compras"
        revendedor -> plataforma "Tenta compras coordenadas por múltiplas contas"
        administrador -> plataforma "Define regras e monitora resultados"
        plataforma -> identidade "Consulta identidade quando a verificação é exigida" {
            tags "Eventual"
        }
        plataforma -> pagamento "Solicita confirmação de pagamento"
    }

    views {
        systemContext plataforma "Contexto" "Pessoas e sistemas externos ligados à plataforma no cenário analisado" {
            include *
            autoLayout lr
        }

        styles {
            element "Person" {
                shape Person
                background #e7f4ee
                color #173e31
                stroke #388064
            }

            element "Adversário" {
                background #fff0e8
                color #6d3922
                stroke #c7784a
            }

            element "Sistema em análise" {
                background #245b9a
                color #ffffff
                stroke #174775
            }

            element "Sistema externo" {
                background #eef1f5
                color #2d3e50
                stroke #8b9baa
            }

            element "Integração eventual" {
                background #eef1f5
                color #2d3e50
                stroke #8b9baa
                border dashed
            }

            relationship "Relationship" {
                color #53657c
                style solid
                thickness 2
            }

            relationship "Eventual" {
                style dashed
            }
        }
    }
}
