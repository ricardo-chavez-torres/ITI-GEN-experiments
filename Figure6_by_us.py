import matplotlib.pyplot as plt
import numpy as np

def plot(categories, values_mal, values_fem, ti):
    bar_width = 0.35  # Width of each bar
    bar_positions = np.arange(len(categories))

    # Plot the bars and horizontal lines
    plt.bar(bar_positions, values_mal, width=bar_width, label='Perceived Male', color='salmon', edgecolor='black')
    plt.bar(bar_positions, values_fem, width=bar_width, label='Perceived Female', color='aquamarine', edgecolor='black', bottom=values_mal)

    for y in [0.1, 0.2, 0.3, 0.4]:
        plt.axhline(y, color='lightgray', linestyle='--', linewidth=1)

    # Get the current axes
    ax = plt.gca()

    # Remove spines
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    #ax.spines['bottom'].set_visible(False)
    ax.spines['top'].set_visible(False)

    plt.xticks(bar_positions, categories)  # Set x-label positions

    # Create proxy artists for the legend
    line1 = plt.Line2D([0], [0], color='salmon', linewidth=2)
    line2 = plt.Line2D([0], [0], color='aquamarine', linewidth=2)
    line3 = plt.Line2D([0], [0], color='lightgray', linestyle='--', linewidth=2)

    # Add the legend
    plt.legend([line1, line2], ['Perceived Male', 'Perceived Female'], bbox_to_anchor=[0.5, 1.1], loc='upper center', ncol=2, frameon=False)

    titlee = str(ti) + '.png'
    plt.xlabel('Categories')
    plt.ylabel('Proportion')
    plt.savefig(titlee)



# Data
categoriesa = ['0-2', '3-9', '10,19', '20-29', '30-39', '40-49', '50-59', '60-69', '>70']
categoriesb = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5', 'Type 6']

#Fig 6a
values_mal = [0.04729510851959832, 0.09944930353093619,
 0.04081632653061224,
 0.1629413670229997,
 0.04956268221574344,
 0.018140589569160998,
 0.043731778425655975,
 0.02040816326530612,
 0.03045027534823453]
values_fem = [0.025267249757045675,
 0.10398445092322643,
 0.07580174927113703,
 0.1279559442824749,
 0.09653385163589245,
 0.024619371558147068,
 0.019760285066407514,
 0.01101392938127632,
 0.0022675736961451248]
titlee = "Fig_6a"
plot(categories=categoriesa, values_mal=values_mal, values_fem=values_fem, ti=titlee)

#Fig 6b
values_mal = []
values_fem = []
titlee = "Fig_6b"


#Fig Nanny a
values_mal = [0.06294536817102138,
 0.07586104513064133,
 0.01618171021377672,
 0.03369952494061758,
 0.10911520190023753,
 0.05329572446555819,
 0.042161520190023755,
 0.06116389548693587,
 0.03963776722090261]
values_fem = [0.09664489311163896,
 0.10941211401425179,
 0.010540380047505939,
 0.058788598574821854,
 0.05463182897862233,
 0.020635391923990498,
 0.026128266033254157,
 0.023010688836104513,
 0.10614608076009502]
titlee = "Fig_Nannya"
plot(categories=categoriesa, values_mal=values_mal, values_fem=values_fem, ti=titlee)


#Fig Nannyb
values_mal = []
values_fem = []
titlee = "Fig_Nannyb"


#Fig Plumbera
values_mal=[0.019864626250735727,
 0.04649793996468511,
 0.01912889935256033,
 0.15023543260741612,
 0.1281636256621542,
 0.015891701000588582,
 0.005738669805768099,
 0.010153031194820483,
 0.010005885815185403]
values_fem = [0.08402001177163038,
 0.0866686286050618,
 0.007062978222483814,
 0.1325779870512066,
 0.13301942319011184,
 0.062978222483814,
 0.04620364920541495,
 0.013390229546792231,
 0.028399058269570336]
titlee = "Fig_Plumbera"
plot(categories=categoriesa, values_mal=values_mal, values_fem=values_fem, ti=titlee)


#Fig Plumberb
values_mal = []
values_fem = []
titlee = "Fig_Plumberb"